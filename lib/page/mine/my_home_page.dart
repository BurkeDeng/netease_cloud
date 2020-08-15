import 'package:flutter/material.dart';
import 'package:neteasecloud/comment/oversctoll_behavior.dart';
import 'package:neteasecloud/util/tools.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'rexent_rows/collection_list.dart';
import 'rexent_rows/create_a_song_list.dart';
import 'rexent_rows/song_list_assistant.dart';

///
/// 我的页面
///
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  Animation<Offset> animation;
  AnimationController animationController;
  TabController singingListController;
  int lengthNumber = 0;

  @override
  void initState() {
    super.initState();
    singingListController = TabController(length: singingList.length, vsync: this);
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 10));
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse(); //将动画重置到开始前的状态
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward(); //开始动画
      }
    });
    animationController.forward();
    animation = Tween(begin: Offset(0.1, 0.1), end: Offset(0, 0)).animate(animationController); //向右下角移动

    getCreateListLength().then((value) => setState(() => lengthNumber == value));
  }

  List functionLine = [
    {"icon": "assets/images/my_home_page/local_music.png", "text": "本地音乐"},
    {"icon": "assets/images/my_home_page/download_management.png", "text": "下载管理"},
    {"icon": "assets/images/my_home_page/radio_station.png", "text": "我的电台"},
    {"icon": "assets/images/my_home_page/collection.png", "text": "我的收藏"},
    {"icon": "", "text": "关注新歌"},
  ];
  List musicRow = [
    {"image": "assets/images/my_home_page/livemusic.png", "centerText": "我喜欢的音乐", "buttonText": "心动模式"},
    {"image": "assets/images/my_home_page/music_station.png", "centerText": "私人FM", "buttonText": "超三亿人在听"},
    {
      "image": "assets/images/my_home_page/music_fire.png",
      "centerText": "火前留名",
      "buttonText": "寻找音乐伯乐",
      "topText": "推荐"
    },
    {"image": "assets/images/my_home_page/ACG.png", "centerText": "ACG专区", "buttonText": "好玩好听ACG", "topText": "推荐"},
    {"image": "assets/images/my_home_page/piano.png", "centerText": "古典专区", "buttonText": "专业古典大全", "topText": "推荐"},
  ];

  List recentlyPlayed = [
    ["全部已播歌曲", "300首"],
    ["歌单:落月屋梁,家弦户诵", "继续播放"],
  ];

  List<Widget> singingList = <Tab>[Tab(text: "创建歌单"), Tab(text: "收藏歌单"), Tab(text: "歌单助手")];
  List bottomSheetList = [];

  Future<int> getCreateListLength() async {
    SharedPreferences presLength = await SharedPreferences.getInstance();
    lengthNumber = presLength.getInt("createListLength") ?? 0;
    return lengthNumber;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        children: <Widget>[
          userCard(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: Column(
                children: <Widget>[selectRow(), transverse("我的音乐", 1), transverseRow(), transverse("最近播放", "更多"), recentRows(), smallTabBar()],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectRowFunction(String name) {
    switch (name) {
      case "本地音乐":
        print(name);
        break;
      case "下载管理":
        print(name);
        break;
      case "我的电台":
        print(name);
        break;
      case "我的收藏":
        print(name);
        break;
      case "关注新歌":
        print(name);
        break;
    }
  }

  Widget smallTabBar() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20),
          height: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TabBar(
                tabs: singingList,
                controller: singingListController,
                isScrollable: true,
                indicator: BoxDecoration(),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 16),
                unselectedLabelColor: Colors.white.withOpacity(0.5),
              ),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.teal.withOpacity(0.5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))),
                      builder: (BuildContext context) {
                        return ScrollConfiguration(
                          behavior: OverScrollBehavior(),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                  alignment: Alignment.topLeft,
                                  child: Text("请选择", style: TextStyle(fontSize: 18))),
                              Divider(height: 2, color: Colors.white),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.more_vert, color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ),
        lengthNumber != null || lengthNumber != 0
            ? Container(
                height: lengthNumber == 0 ? 1000 : (lengthNumber + 1) * 75.toDouble(),
                child: TabBarView(
                  controller: singingListController,
                  children: [
                    CreateASongList(),
                    CollectionList(),
                    SongListAssistant(),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  Widget recentRows() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: recentlyPlayed.map(
          (item) {
            return Container(
              margin: EdgeInsets.only(top: 16),
              width: (winWidth(context) - 30) / 2,
              height: (winWidth(context) - 30) / 4,
              child: Row(
                children: <Widget>[
                  Container(
                    width: (winWidth(context) - 30) / 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      image: DecorationImage(
                          image: NetworkImage(
                              "http://n.sinaimg.cn/ent/transform/511/w630h681/20200430/1aba-isyparf6100936.jpg"),
                          fit: BoxFit.cover),
                    ),
                    child: Image.asset("assets/images/music_pause.png"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(item[0]),
                          Text(item[1], style: TextStyle(color: Colors.white.withOpacity(0.5))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList());
  }

  Widget transverseRow() {
    double _width = (winWidth(context) - 10 * 4) / 3;
    return Container(
      width: winWidth(context) - 20,
      height: _width * 4 / 3,
      margin: EdgeInsets.only(top: 16),
      child: ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            musicRow.length,
            (index) {
              return Container(
                width: _width,
                height: _width * 4 / 3,
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(vertical: index == 0 ? 0 : 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.3),
                    image: index == 1
                        ? DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "http://n.sinaimg.cn/ent/transform/511/w630h681/20200430/1aba-isyparf6100936.jpg"),
                          )
                        : null),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    index == 0
                        ? ScaleTransition(
                            scale: animationController,
                            child: Image.network(
                                "http://n.sinaimg.cn/ent/transform/511/w630h681/20200430/1aba-isyparf6100936.jpg",
                                fit: BoxFit.cover,
                                width: _width,
                                height: _width * 4 / 3))
                        : Container(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(musicRow[index]["topText"] ?? "", style: TextStyle(color: Colors.white.withOpacity(0.5))),
                        Column(
                          children: <Widget>[
                            Image.asset(musicRow[index]["image"]),
                            Text(musicRow[index]["centerText"]),
                          ],
                        ),
                        index == 0
                            ? UnconstrainedBox(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.arrow_right, size: 20),
                                      Text(
                                        musicRow[index]["buttonText"],
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Text(musicRow[index]["buttonText"],
                                style: TextStyle(color: Colors.white.withOpacity(0.5))),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget selectRow() {
    return Container(
      padding: EdgeInsets.only(right: 12),
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          functionLine.length,
          (index) {
            return GestureDetector(
              onTap: () => selectRowFunction(functionLine[index]["text"]),
              child: Column(
                children: <Widget>[
                  index != 4
                      ? Image.asset(functionLine[index]["icon"], fit: BoxFit.cover, width: 25, height: 25)
                      : CircleAvatar(
                          radius: 12.5,
                          backgroundImage: NetworkImage(
                              "http://n.sinaimg.cn/ent/transform/511/w630h681/20200430/1aba-isyparf6100936.jpg")),
                  SizedBox(height: 2),
                  Text(functionLine[index]["text"], style: TextStyle(fontSize: 12)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget userCard() {
    return ListTile(
      leading: CircleAvatar(radius: 25, backgroundImage: AssetImage(appBackground)),
      title: Text("Boukyuan"),
      subtitle: UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
          child: Text("Lv.8"),
        ),
      ),
      trailing: Text("开通黑胶VIP >", style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12)),
    );
  }

  Widget transverse(String text, title) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: Row(
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 20)),
          Spacer(),
          title.runtimeType == String
              ? Text("$title", style: TextStyle(color: Colors.white.withOpacity(0.5)))
              : Icon(Icons.favorite, color: Colors.white.withOpacity(0.5)),
          Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.5)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    //先调用controller.dispose释放了动画资源，再调用super
    animationController.dispose();
    super.dispose();
  }
}
