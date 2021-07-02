import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'nhatkys_model.dart';

class NK_AddPage extends StatefulWidget {
  const NK_AddPage({Key key, this.nkSnapshot}) : super(key: key);
  final NhatKySnapshot nkSnapshot;
  @override
  _NK_AddPageState createState() => _NK_AddPageState();
}

class _NK_AddPageState extends State<NK_AddPage> {

  TextEditingController txtEditdate = TextEditingController();
  TextEditingController txtEditday = TextEditingController();
  TextEditingController txtEditmood = TextEditingController();
  TextEditingController txtEditnote = TextEditingController();
  TextEditingController txtEditweekday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    Future<DateTime> _selectDate(BuildContext context) async {
      var datePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime.now().subtract(Duration(days: 365*50)),
        lastDate: DateTime.now().add(Duration(days: 365*50)),
      );
      if (datePicked != null && datePicked != date)
      {
        setState(() {
          date = datePicked;
          print(date.toString());
          txtEditdate.text = DateFormat('MMM d, yyyy').format(date);
          txtEditday.text = DateFormat('d').format(date);
          txtEditweekday.text = DateFormat('EE').format(date);
        });
      }
      return datePicked;
    }

    return MaterialApp(
      title: "Thêm nhật ký",
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Thêm nhật ký"),
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(Icons.date_range),

                    Expanded(
                      child: TextField(
                        controller: txtEditdate,
                        decoration: InputDecoration(labelText: "Ngày"),
                      ),
                    ),
                    TextButton(onPressed: () => _selectDate(context),child: Icon(Icons.arrow_drop_down_circle),)
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.mood),
                    Expanded(
                      child: TextField(
                        controller: txtEditmood,
                        decoration: InputDecoration(labelText: "Cảm xúc"),
                      ),
                    ),

                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.article_rounded),
                    Expanded(
                      child: TextField(
                        controller: txtEditnote,
                        decoration: InputDecoration(labelText: "Ghi chú"),
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
                        NhatKys nk = NhatKys(
                            date: txtEditdate.text,
                            mood: txtEditmood.text,
                            note: txtEditnote.text,
                            day: txtEditday.text,
                            weekday: txtEditweekday.text
                        );
                        addNhatKyToFirebase(nk);
                        Navigator.pop(context);
                        _showNotification(widget.nkSnapshot.nhatKy.date, context);
                      },
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      child: Text("Hủy"),
                      onPressed: () => {
                        Navigator.pop(context)
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),

                  ],
                )
              ],
            ),
          )
      ),

    );
  }
  void _showNotification(String date, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông Báo"),
            content: Text("Đã thêm thành công nhật ký vào $date"),
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
