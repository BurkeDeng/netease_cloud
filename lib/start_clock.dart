import 'dart:async';
import 'dart:math' as math;
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nav_router/nav_router.dart';

import 'page/homepage.dart';

///启动时钟页
///
class StartClock extends StatefulWidget {
  @override
  _StartClockState createState() => _StartClockState();
}

class _StartClockState extends State<StartClock> {
  int times = 0;
  int timesV=0;
  @override
  void initState() {
    super.initState();
    BotToast.showText(text: "3秒后自动进入播放界面");
    Timer.periodic(Duration(seconds: 1), (v){
      setState(() {});
      print("object.........$v");
      timesV++;
      if(timesV>=3){
        v.cancel();
        v=null;
      }
    });
    Timer.periodic(Duration(seconds: 3), (time) {
      routePush(HomePage());
      print("object.........$time");
      times++;
      if (times >= 1) {
        time.cancel();//取消定时器，避免重复回调
        time = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CustomPaint(painter: TestPainter())));
  }
}

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
      textPainter.text =
          TextSpan(style: TextStyle(color: Colors.cyan, fontSize: 21), text: j == 0 ? '12' : j.toString());
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
