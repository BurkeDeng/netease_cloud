import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImages extends StatefulWidget {
  final String image;
  final double imageWidth;
  final double imageHeight;
   CachedNetworkImages({ this.image,this.imageWidth,this.imageHeight});
  @override
  _CachedNetworkImagesState createState() => _CachedNetworkImagesState();
}

class _CachedNetworkImagesState extends State<CachedNetworkImages> {
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: widget.image,
      fit: BoxFit.cover,
      width:widget.imageWidth,
      height:widget.imageHeight,
      placeholder: (context, url) => Image.asset("assets/images/wait_for.gif",fit: BoxFit.cover),
      errorWidget: (context, url, error) => Image.asset("assets/images/error.jpg",fit: BoxFit.cover),
    );
  }
}
