import 'package:flutter/material.dart';
import 'dart:async';

import 'package:neteasecloud/util/tools.dart';

///歌单助手
class SongListAssistant extends StatefulWidget {
  @override
  _SongListAssistantState createState() => _SongListAssistantState();
}

class _SongListAssistantState extends State<SongListAssistant> {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        height: 200,
        width: winWidth(context) - 44,
        decoration: BoxDecoration(color: Colors.cyanAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}

class SongListAssistantS extends StatefulWidget {
  @override
  _SongListAssistantSPageState createState() => _SongListAssistantSPageState();
}

class _SongListAssistantSPageState extends State<SongListAssistantS> with TickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();
  bool scroll = false;
  int speedFactor = 20;

  _scroll() {
    double maxExtent = _scrollController.position.maxScrollExtent;
    double distanceDifference = maxExtent - _scrollController.offset;
    double durationDouble = distanceDifference / speedFactor;

    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(seconds: durationDouble.toInt()), curve: Curves.linear);
  }

  _toggleScrolling() {
    setState(() {
      scroll = !scroll;
    });
    if (scroll) {
      _scroll();
    } else {
      _scrollController.animateTo(_scrollController.offset, duration: Duration(seconds: 1), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      _toggleScrolling();
    });
  }

  @override
  Widget build(BuildContext context) {
    String val = '''
 BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE. BUNCH OF TEXT HERE.v 
 BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE. BUNCH OF TEXT HERE.v 
 BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE.BUNCH OF TEXT HERE. BUNCH OF TEXT HERE.v 
''';
    return Scaffold(
      body: NotificationListener(
        onNotification: (notif) {
          print("当前位置${_scrollController.offset}");
          if (notif is ScrollEndNotification && scroll) {
            Timer(Duration(seconds: 1), () {
              _scroll();
            });
          }
          return true;
        },
        child: Center(
          child: Container(
            height: 100,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(
                val,
                maxLines: 1000,
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _toggleScrolling();
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
