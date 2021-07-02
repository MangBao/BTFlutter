import 'package:bai4_thuchi/thuchi_model.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:intl/intl.dart';

class TC_AddPage extends StatefulWidget {
  const TC_AddPage({Key key}) : super(key: key);

  @override
  _TC_AddPageState createState() => _TC_AddPageState();
}

class _TC_AddPageState extends State<TC_AddPage> {
  TextEditingController txtAddlydo = TextEditingController();
  TextEditingController txtAddthoigian = TextEditingController();
  TextEditingController txtAddsotien = TextEditingController();
  bool thuchi_radio;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    Future<DateTime> _selectDate(BuildContext context) async {
      var datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now().subtract(Duration(days: 365 * 50)),
        lastDate: DateTime.now().add(Duration(days: 365 * 50)),
      );
      if (datePicked != null && datePicked != date) {
        setState(() {
          date = datePicked;
          print(date.toString());
          txtAddthoigian.text = DateFormat('dd/MM/yyyy').format(date);
        });
      }
      return datePicked;
    }


    return MaterialApp(
      title: "Thêm thu chi",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Thêm thu chi"),
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.create_outlined),
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtAddlydo,
                          decoration: InputDecoration(labelText: "Lý do",border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.monetization_on_outlined),
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtAddsotien,
                          decoration: InputDecoration(
                              labelText: "Số tiền",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.date_range),
                      ),
                      Expanded(
                        child: TextField(
                          controller: txtAddthoigian,
                          decoration: InputDecoration(labelText: "Thời gian"),
                        ),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context),
                        child: Icon(Icons.arrow_drop_down_circle),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton(
                          description: "Thu",
                          value: true,
                          groupValue: thuchi_radio,
                          onChanged: (value) => setState(
                                () => thuchi_radio = value,
                              )),
                      SizedBox(
                        width: 80,
                      ),
                      RadioButton(
                        description: "Chi",
                        value: false,
                        groupValue: thuchi_radio,
                        onChanged: (value) => setState(
                          () => thuchi_radio = value,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: Text("Thêm"),
                        onPressed: () async {
                          //Cập nhật dữ liệu mới
                          ThuChi tc = ThuChi(
                            lydo: txtAddlydo.text,
                            sotien: int.parse(txtAddsotien.text),
                            thoigian: txtAddthoigian.text,
                            thuchi: thuchi_radio
                          );
                          addThuChiToFirebase(tc);
                          Navigator.pop(context);
                          showNotification(tc.lydo, context);
                        },
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        child: Text("Hủy"),
                        onPressed: () => {Navigator.pop(context)},
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  void showNotification(String lydo, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông Báo"),
            content: Text("Đã thêm thành công lý do $lydo"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
