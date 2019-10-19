import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_juejin/net/cache.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter_juejin/utils/index.dart';
import 'package:flutter_juejin/common/global.dart';

parseJSON(String body) async {
  return json.decode(body);
}

class BaseHttp {
  static const _baseUrl = 'https://web-api.juejin.im';

  static const _headers = {
    'X-Agent': 'Juejin/Web',
    'content-type': 'application/json;charset=utf-8'
  };

  static IOClient _client;

  static LinkedHashMap<int, CacheObject> _cache;

  static init() {
    HttpClient client = new HttpClient();
    // proxy
    if (Global.isRelease) {
      String proxy =
          Platform.isAndroid ? '192.168.1.101:8888' : 'localhost:8888';
      client.findProxy = (Uri uri) => 'PROXY $proxy';
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
    }
    _client = IOClient(client);
    _cache = LinkedHashMap<int, CacheObject>();
  }

  static int generateKey(String method, String path, {String body}) {
    return '$method$path$body'.hashCode;
  }

  static interceptRequest(
    String method,
    String path, {
    String body,
    Map<String, String> headers,
    bool useCache = true,
  }) {
    // 没有开启缓存
    if (!Global.enableCache || !useCache) {
      return null;
    }

    int key = generateKey(method, path, body: body);
    var cacheObject = _cache[key];
    // 缓存有效期内
    if (cacheObject != null) {
      if (DateTime.now().millisecondsSinceEpoch - cacheObject.timestamp <
          Global.cacheMaxAge) {
        return cacheObject.response;
      }
    }

    return null;
  }

  static interceptResponse(
    String method,
    String path, {
    String body,
    bool useCache = true,
    Response response,
  }) {
    // 没有开启缓存
    if (!Global.enableCache || !useCache) {
      return null;
    }

    int key = generateKey(method, path, body: body);

    if (_cache.length > Global.cacheMaxCount) {
      _cache.remove(_cache.keys.first);
    }

    _cache[key] = CacheObject(response);
  }

  static Future<Response> actualRequest(
    String method,
    String path, {
    String body,
    Map<String, String> headers,
  }) {
    Future<Response> response;

    switch (method.toLowerCase()) {
      case 'get':
        response = _client.get('$_baseUrl$path', headers: headers);
        break;
      case 'post':
        response = _client.post('$_baseUrl$path', headers: headers, body: body);
        break;
      default:
        throw new Exception('[BaseHttp.request]unknown method');
    }

    return response;
  }

  static Future<dynamic> request(
    String method,
    String path, {
    body,
    Map<String, String> headers,
    bool useCache = true,
    bool parseResponse = true,
  }) async {
    if (_client == null) {
      init();
    }

    path = ensureSlash(path);

    if (headers == null) {
      headers = _headers;
    } else {
      headers.addAll(_headers);
    }

    if (body.runtimeType != String) {
      body = json.encode(body);
    }

    bool canCache = false;

    Response res = interceptRequest(
      method,
      path,
      body: body,
      useCache: useCache,
    );

    if (res == null) {
      res = await actualRequest(
        method,
        path,
        body: body,
        headers: headers,
      );
      canCache = true;
    }

    if (res.statusCode != HttpStatus.ok) {
      throw new Exception('[Error response]${res.statusCode},${res.body}');
    }

    if (canCache) {
      interceptResponse(
        method,
        path,
        body: body,
        response: res,
        useCache: useCache,
      );
    }

    var resBody = Encoding.getByName('utf-8').decode(res.bodyBytes);

    if (parseResponse) {
      return compute(parseJSON, resBody);
    }
    return resBody;
  }
}
