import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neteasecloud/comment/oversctoll_behavior.dart';

///主页Drawer
class HomePageDrawer extends StatefulWidget {
  @override
  _HomePageDrawerState createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  bool modeSwitch = true;
  List drawerButtonList = [
    [Icons.brightness_2, "夜间模式", Icons.brightness_high, "日间模式"],
    ["assets/images/home_page_drawer/setUp.png", "设置"],
    ["assets/images/home_page_drawer/sighOut.png", "退出"],
  ];
  List yunBeiNewsList = [
    [Icons.memory, "云贝中心", "5云贝待领取"],
    [Icons.new_releases, "消息中心", "点击查看新消息"]
  ];
  List musicServiceList = [
    [Icons.volume_mute, "听歌识曲", "", null],
    [Icons.sentiment_very_satisfied, "云村有票", "", null],
    [Icons.add_shopping_cart, "商城", "重地音炮", Icons.add_shopping_cart],
    [Icons.toys, "游戏专区", "手办开箱高能惊喜", Icons.toys],
    [Icons.add_call, "口袋彩铃", "一秒爱上的旋律", Icons.add_call],
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      // 主题组件，可设置局部的主题样式
      data: Config.themeData, // 设置为配置的主题数据
      child: Scaffold(
        body: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, top: 10),
            child: ListView(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), gradient: LinearGradient(colors: [Color(0xff8F8F8F), Color(0xffB4B4B4)])),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("开通黑胶VIP", style: TextStyle(fontSize: 16)),
                        subtitle: Text("加入黑胶VIP,立享超17项专属特权", style: TextStyle(fontSize: 11)),
                        trailing: Container(
                          padding: EdgeInsets.all(5),
                          child: Text("会员中心", style: TextStyle(fontSize: 12)),
                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Divider(height: 2, color: Colors.white, indent: 14, endIndent: 14),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Row(
                          children: [
                            Text("开通VIP仅5元,感受超high现场音效", style: TextStyle(fontSize: 11)),
                            Spacer(),
                            Icon(Icons.star, color: Colors.redAccent)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 80,
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      yunBeiNewsList.length,
                      (index) {
                        return Row(
                          children: [
                            Icon(yunBeiNewsList[index][0], size: 25),
                            SizedBox(width: 5),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(yunBeiNewsList[index][1], style: TextStyle(fontSize: 16)),
                                SizedBox(height: 5),
                                Text(yunBeiNewsList[index][2], style: TextStyle(fontSize: 10))
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10),
                functionList(Icons.wb_incandescent, "创作者中心", "", Icons.keyboard_arrow_right),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(5),
                      color: Colors.white.withOpacity(0.2),
                      child: Text("音乐服务", style: TextStyle(fontSize: 10)),
                    ),
                    Column(
                      children: List.generate(
                        musicServiceList.length,
                        (index) {
                          return functionList(
                              musicServiceList[index][0], musicServiceList[index][1], musicServiceList[index][2], musicServiceList[index][3]);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(5),
                      color: Colors.white.withOpacity(0.2),
                      child: Text("音乐服务", style: TextStyle(fontSize: 10)),
                    ),
                    Column(
                      children: List.generate(
                        musicServiceList.length,
                        (index) {
                          return functionList(
                              musicServiceList[index][0], musicServiceList[index][1], musicServiceList[index][2], musicServiceList[index][3]);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff283233), Color(0xff22414D)])),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              drawerButtonList.length,
              (index) {
                return GestureDetector(
                  onTap: () => buttonFunction(index),
                  child: Row(
                    children: [
                      index == 0
                          ? Icon(drawerButtonList[index][modeSwitch == false ? 0 : 2])
                          : Image.asset(drawerButtonList[index][0], width: 24, height: 24, fit: BoxFit.fill),
                      SizedBox(width: 8),
                      index == 0 ? Text(drawerButtonList[index][modeSwitch == false ? 1 : 3]) : Text(drawerButtonList[index][1]),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  buttonFunction(index) {
    switch (index) {
      case 0:
        setState(() => modeSwitch = !modeSwitch);
        changeTheme();
        break;
      case 1:
        print(index);
        break;
      case 2:
        exit(0); //退出APP
        break;
    }
  }

  ///改变主题
  changeTheme() {
    if (Config.dark) {
      Config.themeData = new ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: new Color(0xFFEBEBEB),
      );
      Config.dark = false;
    } else {
      Config.themeData = new ThemeData.dark();
      Config.dark = true;
    }
    setState(() {});
  }

  Widget functionList(IconData leftIcon, String text, String title, IconData rightIcon) {
    return Container(
      color: Colors.white.withOpacity(0.2),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(leftIcon ?? null, size: 16),
          SizedBox(width: 10),
          Text(text ?? "", style: TextStyle(fontSize: 15)),
          Spacer(),
          Text(title ?? "", style: TextStyle(fontSize: 11)),
          SizedBox(width: 5),
          Icon(rightIcon ?? null, size: 16)
        ],
      ),
    );
  }
}

class Config {
  static bool dark = true; //是否为黑夜模式
  static ThemeData themeData = ThemeData.dark(); //主题为暗色
}
