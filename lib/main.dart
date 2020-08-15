import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import 'start_clock.dart';

void main() {
  runApp(MyApp());
  ///自定义错误页
  ErrorWidget.builder = (FlutterErrorDetails flutterDetails) {
    print("flutterDetails::"+flutterDetails.toString());
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/images/flutter_error.gif",fit: BoxFit.cover),
          Text("Flutter 走神了", style: TextStyle(color: Colors.green,fontSize: 18)),
        ],
      ),
    );
  };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navGK,
      //路由
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        cursorColor: Colors.white, //光标颜色
        brightness: Brightness.dark,
        accentColor: Colors.transparent, //主题次级色，决定大多数Widget的颜色，如进度条、开关等
      ),
      home: StartClock(),
    );
  }
}
