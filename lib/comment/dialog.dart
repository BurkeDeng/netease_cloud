import 'package:flutter/material.dart';
///
/// 自定义弹窗
///
class ShowDialog extends StatefulWidget {
  @override
  _ShowDialogState createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.symmetric(horizontal: 56, vertical: 304),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(height: 5),
              Text(
                "新增学历类型",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff595959),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  cursorColor: Colors.transparent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)),
                      hintText: "输入1~5字",
                      hintStyle:
                          TextStyle(fontSize: 14, color: Color(0xFFBFBFBF))),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: Color(0xffE1E1E1)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: (MediaQuery.of(context).size.width - 56 * 2) / 2,
                        alignment: Alignment.center,
                        child: Text("取消",
                            style: TextStyle(
                                fontSize: 16, color: Color(0xFF8C8C8C))),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(border: Border(left: BorderSide(width: 1,color: Color(0xffE1E1E1)))),
                      width: (MediaQuery.of(context).size.width - 56 * 2) / 2,
                      alignment: Alignment.center,
                      child: Text("确认",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFF1890FF))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
