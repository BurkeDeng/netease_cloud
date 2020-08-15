
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

///底部弹出选择列表
///
///
class TreatmentRequirements extends StatefulWidget {
  @override
  _TreatmentRequirementsState createState() => _TreatmentRequirementsState();
}

class _TreatmentRequirementsState extends State<TreatmentRequirements> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List topHalfList = [];
  List halfTheNumber = [];
  List annualSalary = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          FlatButton(onPressed: () => showPickerMonthlySalary(context), child: Text("选择月薪"), color: Colors.green),
          FlatButton(onPressed: () => showPickerAnnualSalary(context), child: Text("选择年薪"), color: Colors.green)
        ],
      ),
    );
  }

  void showPickerMonthlySalary(BuildContext context) {
    for (int j = 1; j <= 20; j++) setState(() => topHalfList.add("${j.toString()}k"));
    for (int i = 11; i <= 30; i++) setState(() => halfTheNumber.add("${i.toString()}k"));
    Picker(
      adapter: PickerDataAdapter(
          data: topHalfList.map((minimum) {
        return PickerItem(
            text: Text("$minimum"),
            value: Text("$minimum"),
            children: halfTheNumber.map((item) {
              return PickerItem(text: Text("$item"));
            }).toList());
      }).toList()),
      delimiter: [
        PickerDelimiter(
            child: Container(
          color: Colors.white,
          width: 30.0,
          alignment: Alignment.center,
          child: Text("—", style: TextStyle(color: Color(0xff1890FF), fontSize: 16)),
        ))
      ],
      height: MediaQuery.of(context).size.height * 0.25,
      cancelText: "取消",
      cancelTextStyle: TextStyle(color: Colors.grey),
      confirmText: "确定",
      confirmTextStyle: TextStyle(color: Colors.cyan),
      headercolor: Colors.white,
      title: Text("月薪", style: TextStyle(color: Colors.black)),
      onConfirm: (Picker picker, List value) {
        print("value${value.toString()}");
        print("选择的最低工资${topHalfList[value[0]]}");
        print("选择的最高工资${halfTheNumber[value[1]]}");
      },
    ).show(_scaffoldKey.currentState);
  }
  void showPickerAnnualSalary(BuildContext context) {
    for (int k = 10; k <= 50; k++) setState(() => annualSalary.add("${k.toString()}"));
    print("object$annualSalary");
    String pickerData = "$annualSalary";
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: JsonDecoder().convert(pickerData)),
        selectedTextStyle: TextStyle(color: Colors.blue),
        height: MediaQuery.of(context).size.height * 0.25,
        cancelText: "取消",
        cancelTextStyle: TextStyle(color: Colors.grey),
        confirmText: "确定",
        confirmTextStyle: TextStyle(color: Colors.cyan),
        headercolor: Colors.white,
        title: Text("年薪", style: TextStyle(color: Colors.black)),
        onConfirm: (Picker picker, List value) {
          print(picker.adapter.text);
          print("选择的年薪${annualSalary[value[0]]}");
        }).showModal(this.context);
  }
}
