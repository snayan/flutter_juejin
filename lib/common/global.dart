import 'package:flutter_juejin/net/base.dart';

class Global {
  // 是否release模式
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 是否缓存接口
  static bool get enableCache => true;

  // 缓存最大时间，默认为10分钟
  static int get cacheMaxAge => 10 * 60 * 1000;

  // 最大缓存数量
  static int get cacheMaxCount => 20;

  static init() async {
    BaseHttp.init();
  }
}
