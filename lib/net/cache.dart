import 'package:http/http.dart';

class CacheObject {
  CacheObject(this.response)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  Response response;
  int timestamp;

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode {
    return response.request.url.hashCode;
  }
}

