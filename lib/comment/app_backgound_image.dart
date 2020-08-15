import 'package:flutter/material.dart';
import 'package:neteasecloud/util/tools.dart';


///app背景图片
class AppBackgroundImage extends StatefulWidget {
  @override
  _AppBackgroundImageState createState() => _AppBackgroundImageState();
  final Widget child;
  AppBackgroundImage({ this.child});
}

class _AppBackgroundImageState extends State<AppBackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(appBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: widget.child,
    );
  }
}
