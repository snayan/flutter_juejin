import 'package:flutter_juejin/net/base.dart';

class Global {
  // 是否release模式
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static init() async {
    BaseHttp.init();
  }
}
