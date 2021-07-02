import 'package:bai1_qlmh/monhoc_model.dart';
import 'package:flutter/material.dart';

class MH_AddPage extends StatefulWidget {
  @override
  _MH_AddPageState createState() => _MH_AddPageState();
}

class _MH_AddPageState extends State<MH_AddPage> {

  TextEditingController txtAddMaMh = TextEditingController();
  TextEditingController txtAddTenMonHoc = TextEditingController();
  TextEditingController txtAddSoTC = TextEditingController();
  TextEditingController txtAddDiemTB = TextEditingController();
  TextEditingController txtAddHocKi = TextEditingController();
  bool batbuoc;

  @override
  Widget build(BuildContext context) {
    batbuoc = false;
    return Scaffold(
        appBar: AppBar(
          title: Text("Thêm môn học"),
          backgroundColor: Colors.lightBlue,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: txtAddMaMh,
                      decoration: InputDecoration(
                          labelText: "Mã môn học",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txtAddTenMonHoc,
                      decoration: InputDecoration(
                          labelText: "Tên môn học",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txtAddSoTC,
                      decoration: InputDecoration(
                          labelText: "Số tín chỉ",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txtAddHocKi,
                      decoration: InputDecoration(
                          labelText: "Học kì",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: txtAddDiemTB,
                      decoration: InputDecoration(
                          labelText: "Điểm trung bình",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          )),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
              StatefulBuilder(
                //Sử dụng StatefulBuilder khi bạn cần truy cập vào setState của cây con đó.
                // Điều này sẽ chỉ xây dựng lại StatefulBuildervới cây con của nó.
                builder: (BuildContext context, StateSetter setState) {
                  return Center(
                    child: CheckboxListTile(
                      title: Text("Bắt buộc"),
                      value: batbuoc,
                      onChanged: (bool value) {
                        setState(() {
                          batbuoc = value;
                        });
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  MonHoc monhoc = MonHoc(
                      mamh: txtAddMaMh.text,
                      tenmh: txtAddTenMonHoc.text,
                      sotc: int.parse(txtAddSoTC.text),
                      hocki: int.parse(txtAddHocKi.text),
                      diemtb: double.parse(txtAddDiemTB.text),
                      batbuoc: batbuoc);
                  addMonHocToFirebase(monhoc);
                  Navigator.pop(context);
                  _showNotification(monhoc.tenmh, context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        ));
  }

  void _showNotification(String tenmh, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông Báo"),
            content: Text("Đã thêm thành công môn học $tenmh"),
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
