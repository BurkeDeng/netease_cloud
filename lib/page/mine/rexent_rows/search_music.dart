import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:neteasecloud/comment/app_backgound_image.dart';
import 'package:neteasecloud/util/tools.dart';

///搜索音乐
class SearchForMusic extends StatefulWidget {
  final String randomSinger;
  final String randomSongTitle;

  SearchForMusic({this.randomSinger, this.randomSongTitle});

  @override
  _SearchForMusicState createState() => _SearchForMusicState();
}

class _SearchForMusicState extends State<SearchForMusic> with SingleTickerProviderStateMixin {
  List<Widget> listOfSongTypes = <Tab>[
    Tab(text: "综合"),
    Tab(text: "单曲"),
    Tab(text: "歌单"),
    Tab(text: "视频"),
    Tab(text: "声音"),
  ];
  TabController songTypesController;
  TextEditingController textController = new TextEditingController();
  bool existenceList = false;

  @override
  void initState() {
    super.initState();
    songTypesController = TabController(length: listOfSongTypes.length, vsync: this);
    searchSingleList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff2D6F54),
          elevation: 0,
          leading: pageReturn(context),
          title: TextField(
            onSubmitted: (text) {
              setState(() => existenceList = true);
            },
            controller: textController,
            cursorColor: Colors.white,
            cursorWidth: 3,
            style: TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search,
            autofocus: true,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.close, color: Colors.white),
                onPressed: () => setState(() => textController.text = ""),
              ),
              hintText: "${widget.randomSongTitle} - ${widget.randomSinger}" ?? "",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            ),
          ),
          bottom: existenceList == false
              ? null
              : PreferredSize(
                  preferredSize: Size(0, 44),
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent, //点击的背景高亮颜色
                      splashColor: Colors.transparent, //点击水波纹颜色
                    ),
                    child: TabBar(
                      tabs: listOfSongTypes,
                      controller: songTypesController,
                      indicatorColor: Colors.transparent,
                      labelColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 20),
                      unselectedLabelColor: Colors.white.withOpacity(0.5),
                      unselectedLabelStyle: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
        ),
        body: AppBackgroundImage(child: customLoseFocus(context, ListView())),
      ),
    );
  }

  Future<dynamic> searchSingleList() async {
    Dio getSingleList = new Dio();
    String keyword = widget.randomSinger;
    try {
      Response response = await getSingleList.get("https://v1.alapi.cn/api/music/search?keyword=$keyword");
      if (response.statusCode == 200) {
        print("请求数据>>>>>>>>>>>>>${response.data}");
        return response.data;
      } else {
        print("搜索单曲请求状态码出错${response.statusCode}");
      }
    } catch (e) {
      print("请求出错" + e);
      return e;
    }
  }
}
