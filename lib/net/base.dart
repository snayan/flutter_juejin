import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
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
  }

  static Future<dynamic> request(String method, String path,
      {body, Map<String, String> headers, bool parseResponse = true}) {
    if (_client == null) {
      init();
    }

    path = ensureSlash(path);

    if (headers == null) {
      headers = _headers;
    } else {
      headers.addAll(_headers);
    }

    Future<Response> response;

    switch (method.toLowerCase()) {
      case 'get':
        response = _client.get('$_baseUrl$path', headers: headers);
        break;
      case 'post':
        if (body.runtimeType != String) {
          body = json.encode(body);
        }
        response = _client.post('$_baseUrl$path', headers: headers, body: body);
        break;
      default:
        throw new Exception('[BaseHttp.request]unknown method');
    }

    return response.then((res) {
      if (res.statusCode != HttpStatus.ok) {
        throw new Exception('[Error response]${res.statusCode},${res.body}');
      }

      var body = Encoding.getByName('utf-8').decode(res.bodyBytes);

      if (parseResponse) {
        return compute(parseJSON, body);
      }
      return body;
    });
  }
}
