import 'package:flutter/material.dart';
import 'package:flutter_juejin/root.dart';
import 'package:flutter_juejin/common/global.dart';

void main() async {
  await Global.init();
  runApp(JuejinApp());
}

class JuejinApp extends StatelessWidget {
  static get appTheme {
    final theme = ThemeData.light();
    return theme.copyWith(
      textTheme: theme.textTheme.copyWith(
        caption: theme.textTheme.caption.copyWith(
          color: Color(0xffb2bac2),
        ),
        subhead: theme.textTheme.subhead.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: theme.cardTheme.copyWith(
        margin: EdgeInsets.zero,
        elevation: 0,
        shape: Border(
          bottom: BorderSide(
            width: 0.5, // todo: 根据DPR来设置
            color: Color.fromARGB(100, 178, 186, 194),
          ),
        ),
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'juejin',
      theme: appTheme,
      home: RootWidget(),
    );
  }
}
