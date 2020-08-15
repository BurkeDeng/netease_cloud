import 'package:flutter/material.dart';

//屏幕宽度
double winWidth(BuildContext context){
  return MediaQuery.of(context).size.width;
}
//屏幕高度
double winHeight(BuildContext context ){
  return MediaQuery.of(context).size.height;
}

String appBackground="assets/images/appBackground.jpg";

//app背景图片
Decoration appBackGroundImage(){
  return BoxDecoration(
    image: DecorationImage(
      image: AssetImage(appBackground),
      fit: BoxFit.cover,
    ),
  );
}