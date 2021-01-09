import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:neteasecloud/util/tools.dart';

///视频播放
class VideoHomePage extends StatefulWidget {
  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: winHeight(context),
        width: winWidth(context) - 28,
        margin: EdgeInsets.fromLTRB(10, 5, 10, 80),
        child: StaggeredGridView.countBuilder(
          crossAxisCount: 4,
          itemCount: 21,
          itemBuilder: (BuildContext context, int index) => Container(
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
            child: Center(child: CircleAvatar(backgroundColor: Colors.white, child: Text('$index'))),
          ),
          staggeredTileBuilder: (int index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
  }
}
