import 'package:bai1_qlmh/monhoc_model.dart';
import 'package:flutter/material.dart';

class MH_EditPage extends StatefulWidget {
  final MonHocSnapshot mhSnapshot;

  const MH_EditPage({Key key, @required this.mhSnapshot}) : super(key: key);

  @override
  _MH_EditPageState createState() => _MH_EditPageState();
}

class _MH_EditPageState extends State<MH_EditPage> {
  MonHocSnapshot mhSnapshot;
  TextEditingController txtEditMaMh = TextEditingController();
  TextEditingController txtEditTenMH = TextEditingController();
  TextEditingController txtEditSoTC = TextEditingController();
  TextEditingController txtEditDiemTB = TextEditingController();
  TextEditingController txtEditHocKi = TextEditingController();
  bool bb;

  @override
  Widget build(BuildContext context) {

    txtEditMaMh.text = widget.mhSnapshot.monHoc.mamh;
    txtEditTenMH.text = widget.mhSnapshot.monHoc.tenmh;
    txtEditSoTC.text = widget.mhSnapshot.monHoc.sotc.toString();
    txtEditHocKi.text = widget.mhSnapshot.monHoc.hocki.toString();
    txtEditDiemTB.text = widget.mhSnapshot.monHoc.diemtb.toString();
    bb = widget.mhSnapshot.monHoc.batbuoc;

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cập nhật"),
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
                        controller: txtEditMaMh,
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
                        controller: txtEditTenMH,
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
                        controller: txtEditSoTC,
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
                        controller: txtEditHocKi,
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
                        controller: txtEditDiemTB,
                        decoration: InputDecoration(
                            labelText: "Điểm trung bình",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            )),
                      ),
                    ],
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Center(
                      child: CheckboxListTile(
                        title: Text("Bắt buộc"),
                        value: bb,
                        onChanged: (bool value) {
                          setState(() {
                            bb = value;
                          });
                        },
                      ),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          await widget.mhSnapshot.update(
                              mamh: txtEditMaMh.text,
                              tenmh: txtEditTenMH.text,
                              sotc: int.parse(txtEditSoTC.text),
                              hocki: int.parse(txtEditHocKi.text),
                              diemtb: double.parse(txtEditDiemTB.text),
                              batbuoc: bb);

                          Navigator.pop(context);
                          _showNotification(widget.mhSnapshot.monHoc.tenmh, context);
                        },
                        child: Text("Cập nhật")
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Thoát"),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  void _showNotification(String tenmh, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông Báo"),
            content: Text("Đã cập nhật thành công môn học $tenmh"),
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
