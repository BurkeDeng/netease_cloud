import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

///发现主页
class FindHomePage extends StatefulWidget {
  @override
  _FindHomePageState createState() => _FindHomePageState();
}

class _FindHomePageState extends State<FindHomePage> with AutomaticKeepAliveClientMixin {
  List<String> bannerImages = [];

  @override
  void initState() {
    super.initState();
    getImageUrl().then((value) {
      for (int i = 0; i < value.length; i++) {
        bannerImages.add(value[i]["picUrl"]);
      }
      setState(() {});
    });
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
      } else {
        print("网络图片请求出错${response.statusCode}");
      }
    } catch (e) {
      print(">>>>>>>>>>>>>>>>>>$e");
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Container(
              height: 150,
              child: Swiper(
                autoplay: true,
                itemCount: bannerImages.length,
                pagination: bannerImages.length > 0 ? SwiperPagination() : null, //分页指示器
                viewportFraction: 0.8,
                scale: 0.9,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(bannerImages[index], fit: BoxFit.fill);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
