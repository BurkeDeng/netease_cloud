///
///技术点
///

///获取组件大小和位置
//     GlobalKey _keyRed = GlobalKey();
// void initState() {
//   //监听Widget是否绘制完毕
//   WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
//   super.initState();
// }
// void _afterLayout(_) {
//   final RenderBox renderBoxBlue = _keyRed.currentContext.findRenderObject();
//   final sizeBlue = renderBoxBlue.size;//大小
//   final positionsBlue = renderBoxBlue.localToGlobal(Offset(0, 0));//位置
// }
