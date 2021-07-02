import 'package:bai2_nhatkys/nhatkys_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NK_EditPage extends StatefulWidget {
  final NhatKySnapshot nkSnapshot;

  const NK_EditPage({Key key, @required this.nkSnapshot}) : super(key: key);

  @override
  _NK_EditPageState createState() => _NK_EditPageState();
}

class _NK_EditPageState extends State<NK_EditPage> {
  /*NhatKySnapshot nhatKySnapshot;*/
  TextEditingController txtEditdate = TextEditingController();
  TextEditingController txtEditday = TextEditingController();
  TextEditingController txtEditmood = TextEditingController();
  TextEditingController txtEditnote = TextEditingController();
  TextEditingController txtEditweekday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    txtEditmood.text = widget.nkSnapshot.nhatKy.mood;
    txtEditnote.text = widget.nkSnapshot.nhatKy.note;
    /*txtEditdate.text = widget.nkSnapshot.nhatKy.date;*/

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
          txtEditday.text =DateFormat('d').format(date);
          txtEditweekday.text = DateFormat('EE').format(date);

        });
      }
      return datePicked;
    }

    return MaterialApp(
      title: "Cập nhật nhật ký",
      theme: ThemeData(
          primarySwatch: Colors.blue
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cập nhật nhật ký"),
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
                      child: Text("Update"),
                      onPressed: () async {
                        //Cập nhật dữ liệu mới
                        await widget.nkSnapshot.update(
                            date: txtEditdate.text,
                            mood: txtEditmood.text,
                            note: txtEditnote.text,
                            day: txtEditday.text,
                            weekday: txtEditweekday.text
                        );

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
            content: Text("Đã cập nhật thành công nhật ký vào $date"),
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
