import 'package:flutter/material.dart';
import 'package:neteasecloud/comment/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateASongList extends StatefulWidget {
  @override
  _CreateASongListState createState() => _CreateASongListState();
}

class _CreateASongListState extends State<CreateASongList> {
  List createList = [
    {
      "images": "http://uploadfile.bizhizu.cn/up/ee/2d/57/ee2d576a98e25b1aa44be6b402380207.jpg.source.jpg",
      "text": "浮生若梦,相思如墨",
      "number": 125,
      "number2": 40
    },
    {
      "images": "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1794423878,2930625248&fm=26&gp=0.jpg",
      "text": "浮生若梦,相思如墨",
      "number": 125,
      "number2": 40
    },
    {
      "images": "http://dingyue.ws.126.net/2019/05/09/014747ed4bac40f0909629ec6046edda.jpeg",
      "text": "浮生若梦,相思如墨",
      "number": 125,
      "number2": 40
    },
    {
      "images": "http://i.shangc.net/2017/0813/20170813040255768.jpg",
      "text": "浮生若梦,相思如墨",
      "number": 125,
      "number2": 40
    },
    {
      "images": "http://i.shangc.net/2017/0813/20170813040255768.jpg",
      "text": "浮生若梦,相思如墨",
      "number": 125,
      "number2": 40
    },
  ];

  @override
  void initState() {
    super.initState();
    createListNumber();
  }

  createListNumber() async {
    SharedPreferences pres = await SharedPreferences.getInstance();
    pres.setInt("createListLength", createList.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(createList.length, (index) {
          return ListTile(
            leading: CachedNetworkImages(image: createList[index]["images"], imageWidth: 75, imageHeight: 75),
            title: Text(createList[index]["text"] ?? ""),
            subtitle: Row(
              children: <Widget>[
                Image.asset("assets/images/my_home_page/download_successful.png" ?? 0, width: 15, height: 15),
                Text("${createList[index]["number"] ?? ""}首,已下载${createList[index]["number2"] ?? ""}首"),
              ],
            ),
            trailing: Icon(Icons.more_vert),
          );
        },
      ),
    );
  }
}
