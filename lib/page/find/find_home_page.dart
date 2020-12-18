import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:neteasecloud/comment/app_backgound_image.dart';
import 'package:neteasecloud/comment/cached_network_image.dart';

///发现主页
class FindHomePage extends StatefulWidget {
  @override
  _FindHomePageState createState() => _FindHomePageState();
}

class _FindHomePageState extends State<FindHomePage> with AutomaticKeepAliveClientMixin {
  List<String> bannerImages = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getImageUrl().then((value) {
      for (int i = 0; i < value.length; i++) bannerImages.add(value[i]["picUrl"]);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AppBackgroundImage(child: ListView(children: [bannerImage()]));
  }

  //轮播图
  Widget bannerImage() {
    return Container(
      height: 150,
      child: Swiper(
        autoplay: true,
        itemCount: bannerImages.length,
        pagination: bannerImages.length > 0 ? SwiperPagination() : null,
        viewportFraction: 0.8, //分页指示器
        scale: 0.9,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(borderRadius: BorderRadius.circular(15), child: CachedNetworkImages(image: bannerImages[index]));
        },
      ),
    );
  }

  // ignore: missing_return
  Future<List> getImageUrl() async {
    Dio dio = new Dio();
    Response response;
    try {
      response = await dio.get("https://music.163.com/api/personalized/newsong");
      if (response.statusCode == 200) {
        var getModel = response.data;
        var jsonModel = jsonDecode(getModel);
        return jsonModel["result"];
      } else
        print("状态码${response.statusCode}");
    } catch (e) {
      print("请求出错$e");
      return e;
    }
  }
}
