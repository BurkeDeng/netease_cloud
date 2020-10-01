import 'dart:async';
import 'dart:math' as math;
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';
import 'package:neteasecloud/util/tools.dart';

import 'page/homepage.dart';

///启动时钟页
///
class StartClock extends StatefulWidget {
  @override
  _StartClockState createState() => _StartClockState();
}

class _StartClockState extends State<StartClock> with SingleTickerProviderStateMixin {
  double timesV = 0;
  AnimationController _animationController;
  SplashAnimManager _splashAnimManager;
  List textNumber = [
    ["生而", "为人"],
    ["我很", "抱歉"],
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 4000));
    Future.delayed(Duration(milliseconds: 0)).then((value) {
      _animationController.forward();
      Future.delayed(Duration(milliseconds: 5000), () {
        routePush(HomePage());
      });
    });
    BotToast.showText(text: "5秒后自动进入播放界面", align: Alignment.topCenter, duration: Duration(seconds: 5));
    Timer.periodic(Duration(seconds: 1), (v) {
      setState(() => timesV++);
      if (timesV >= 5) {
        v.cancel();
        v = null;
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _splashAnimManager = SplashAnimManager(_animationController, winWidth(context), (_getTextWidth("到点") - _getTextWidth("上号") - 4) / 2);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/my_home_page/stackImage.jpg"), fit: BoxFit.fill),
          color: Colors.white54,
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            CustomPaint(painter: TestPainter()),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: textNumber.map((item) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    height: 100,
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        animation(
                            null,
                            _splashAnimManager.animLeft.value,
                            item[0],
                            item[1].hashCode == 344964552 ? 5 : 0,
                            item[0].hashCode == 377705094
                                ? BoxDecoration(color: Color.fromARGB(255, 253, 152, 39), borderRadius: BorderRadius.circular(20))
                                : null),
                        animation(
                            _splashAnimManager.animRight.value,
                            null,
                            item[1],
                            item[0].hashCode == 377705094 ? 0 : 5,
                            item[1].hashCode == 344964552
                                ? null
                                : BoxDecoration(color: Color.fromARGB(255, 253, 152, 39), borderRadius: BorderRadius.circular(20)))
                      ],
                    ),
                  );
                }).toList()),
          ],
        ),
      ),
    );
  }

  double _getTextWidth(String title) {
    final textPainter = TextPainter(
      text: TextSpan(text: title, style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, color: Colors.blue)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0.0, maxWidth: double.infinity);
    return textPainter.width;
  }

  Widget animation(double left, double right, String text, double padding, Decoration decoration) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Positioned(
            left: left,
            right: right,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding),
                decoration: decoration,
                child: Text(text, style: TextStyle(fontSize: 60, color: Colors.blue))));
      },
    );
  }
}

//画笔
class TestPainter extends CustomPainter {
  Paint _bigCirclePaint = Paint()
    ..color = Colors.cyan
    ..style = PaintingStyle.stroke
    ..strokeWidth = 4;

  Paint _linePaint = Paint()
    ..color = Colors.teal
    ..style = PaintingStyle.fill;

  TextPainter textPainter = TextPainter(textAlign: TextAlign.left, textDirection: TextDirection.ltr);
  Offset _center = Offset(0, 0);
  double _radius = math.min(400 / 3, 400 / 3);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(_center, _radius, _bigCirclePaint); //大圆
    _bigCirclePaint
      ..style = PaintingStyle.fill
      ..color = Colors.cyan;
    canvas.drawCircle(_center, _radius / 20, _bigCirclePaint); //圆心
    for (int i = 0; i < 60; i++) {
      _linePaint..strokeWidth = i % 5 == 0 ? (i % 3 == 0 ? 10 : 4) : 1;
      canvas.drawLine(Offset(0, _radius - 10), Offset(0, _radius), _linePaint);
      canvas.rotate(math.pi / 30);
    }
    for (int j = 0; j < 12; j++) {
      canvas.save();
      canvas.translate(0.0, -_radius + 30);
      textPainter.text = TextSpan(style: TextStyle(color: Colors.cyan, fontSize: 21), text: j == 0 ? '12' : j.toString());
      canvas.rotate(-degZRad(30) * j);
      textPainter.layout();
      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore(); //重置
      canvas.rotate(degZRad(30));
    }
    int _hour = DateTime.now().hour;
    int _minute = DateTime.now().minute;
    int _second = DateTime.now().second;
    //时针
    double hourAngle = (_minute / 60 + _hour - 12) * math.pi / 6;
    _linePaint.strokeWidth = 4;
    canvas.rotate(hourAngle);
    canvas.drawLine(Offset(0, 0), Offset(0, -_radius + 80), _linePaint);
    //分针
    double minuteAngle = (_minute + _second / 60) * math.pi / 30;
    _linePaint.strokeWidth = 2;
    canvas.rotate(-hourAngle);
    canvas.rotate(minuteAngle);
    canvas.drawLine(Offset(0, 0), Offset(0, -_radius + 60), _linePaint);
    //秒针
    double secondAngle = _second * math.pi / 30;
    _linePaint.strokeWidth = 1;
    canvas.rotate(-minuteAngle);
    canvas.rotate(secondAngle);
    canvas.drawLine(Offset(0, 0), Offset(0, -_radius + 30), _linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  num degZRad(num v) {
    return v * (math.pi / 180);
  }
}

class SplashAnimManager {
  final AnimationController controller;
  final Animation<double> animLeft;
  final Animation<double> animRight;
  final double screenWidth;
  final double offset;

  SplashAnimManager(this.controller, this.screenWidth, this.offset)
      : animLeft = Tween(begin: screenWidth, end: screenWidth / 2 - offset).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn)),
        animRight = Tween(begin: screenWidth, end: screenWidth / 2 + offset).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
}
