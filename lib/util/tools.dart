import 'package:flutter/material.dart';

//屏幕宽度
double winWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//屏幕高度
double winHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

//app背景图片
String appBackground = "assets/images/appBackground.jpg";

Decoration appBackGroundImage() {
  return BoxDecoration(
    image: DecorationImage(image: AssetImage(appBackground), fit: BoxFit.cover),
  );
}

class Config {
  static bool dark = true; //是否为黑夜模式
  static ThemeData themeData = ThemeData.dark(); //主题为暗色
}

//页面返回键
Widget pageReturn(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pop(context),
    child: Icon(Icons.keyboard_arrow_left, size: 50, color: Colors.white),
  );
}


//失去焦点
Widget customLoseFocus(BuildContext context,Widget widget){
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: (){FocusScope.of(context).requestFocus(FocusNode());},
    child: widget,
  );
}