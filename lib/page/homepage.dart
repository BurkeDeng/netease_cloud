import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neteasecloud/comment/app_backgound_image.dart';
import 'package:neteasecloud/comment/oversctoll_behavior.dart';
import 'package:neteasecloud/page/find/find_home_page.dart';
import 'package:neteasecloud/page/mine/my_home_page.dart';
import 'package:neteasecloud/page/video/video_home_page.dart';
import 'package:neteasecloud/page/yuncun/yuncun_home_page.dart';
import 'package:neteasecloud/util/tools.dart';
import 'homepage_drawer.dart';

///导航栏
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  final List<Widget> tabsList = <Tab>[Tab(text: "我的"), Tab(text: "发现"), Tab(text: "云村"), Tab(text: "视频")];
  TabController _tabController;
  bool isNotPlaying = false;
  DateTime lastPopTime;
  String randomSinger, randomSongTitle, randomSongPictures, randomSongPath;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabsList.length, vsync: this);
    getRandomPlay().then((value) {
      randomSinger = value["artists_name"];
      randomSongTitle = value["name"];
      randomSongPictures = value["music_pic"];
      randomSongPath = value["music_url"];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () async {
        // 点击返回键的操作
        if (lastPopTime == null || DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
          lastPopTime = DateTime.now();
          BotToast.showText(text: "再点击一次退出");
        } else {
          lastPopTime = DateTime.now();
          // 退出app
          await SystemChannels.platform.invokeMethod("SystemNavigator.pop");
        }
      },
      child: SafeArea(
        child: Scaffold(
          drawer: Drawer(elevation: 0, child: HomePageDrawer()),
          body: AppBackgroundImage(
            child: ScrollConfiguration(
              behavior: OverScrollBehavior(),
              child: ListView(
                children: <Widget>[
                  tabBarModel(),
                  Container(
                    height: winHeight(context) - 44,
                    child: TabBarView(controller: _tabController, children: [MyHomePage(), FindHomePage(), YunCunHomePage(), VideoHomePAge()]),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: Color(0xff142510),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(randomSongPictures == null
                      ? "http://n.sinaimg.cn/ent/transform/511/w630h681/20200430/1aba-isyparf6100936.jpg"
                      : randomSongPictures),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(randomSongTitle == null ? "消愁" : randomSongTitle, style: TextStyle(fontSize: 15, color: Colors.white)),
                    Text(randomSinger == null ? "毛不易" : randomSinger, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
                  ],
                ),
                Spacer(),
                InkWell(
                    onTap: () => setState(() => isNotPlaying = !isNotPlaying),
                    child: isNotPlaying == false ? Image.asset("assets/images/music_pause.png") : Image.asset("assets/images/music_playing.png")),
                SizedBox(width: 15),
                Image.asset("assets/images/music_list.png", fit: BoxFit.cover, width: 25, height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///顶部导航
  Widget tabBarModel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return GestureDetector(onTap: () => Scaffold.of(context).openDrawer(), child: Icon(Icons.menu, color: Colors.black, size: 28));
            },
          ),
          TabBar(
              tabs: tabsList,
              controller: _tabController,
              indicator: BoxDecoration(),
              isScrollable: true,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 16)),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.search, size: 28, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // ///请求随机播放的歌曲
  Future<dynamic> getRandomPlay() async {
    Dio getRandomMusic = new Dio();
    try {
      Response response = await getRandomMusic.get("https://api.66mz8.com/api/rand.music.163.php?format=json");
      if (response.statusCode == 200) {
        return response.data;
      } else
        print("随机歌曲状态码出错啦${response.statusCode}");
    } catch (e) {
      print("随机歌曲请求出错$e");
      return e;
    }
  }
}
