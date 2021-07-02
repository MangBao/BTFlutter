import 'package:bai1_qlmh/models/mon_hoc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MonHocPage extends StatefulWidget {
  const MonHocPage({Key key}) : super(key: key);

  @override
  _MonHocPageState createState() => _MonHocPageState();
}

class _MonHocPageState extends State<MonHocPage> {
  String title = "";
  String buttonLabel = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allUser(context),
      floatingActionButton: Row(
        children: [
          Expanded(child: SizedBox()),
          ElevatedButton(
              onPressed: () => _showDialogAdd(context),
              child: Icon(Icons.add)),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _allUser(BuildContext context) {
    return StreamBuilder<List<MonHocSnapshot>>(
      stream: getAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Cập nhật',
                    color: Colors.green,
                    icon: Icons.update,
                    onTap: () => _showDialogEdit(context, snapshot.data[index]),
                    closeOnTap: true,
                  ),
                  IconSlideAction(
                    caption: 'Xóa',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      _showDialog(snapshot.data[index], context);
                    },
                  ),
                ],
                child: ListTile(
                  leading: Icon(Icons.face_sharp),
                  title: Text(
                    snapshot.data[index].mh.tenMH,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(snapshot.data[index].mh.diemTB.toString()),
                  trailing: Text(
                    '${snapshot.data[index].mh.soTC.toString()}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  TextEditingController txtMaMH = TextEditingController();
  TextEditingController txtTenMH = TextEditingController();
  TextEditingController txtSoTC = TextEditingController();
  TextEditingController txtDiemTB = TextEditingController();
  TextEditingController txtHocKy = TextEditingController();
  TextEditingController txtBatBuoc = TextEditingController();

  void _showDialogAdd(BuildContext context) {
    title = "Thêm môn học";
    buttonLabel = "Thêm";
    txtMaMH.clear();
    txtTenMH.clear();
    txtSoTC.clear();
    txtDiemTB.clear();
    txtHocKy.clear();
    txtBatBuoc.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(title),
          content: Container(
            width: 130.0,
            height: 220.0,
            child: Column(
              children: [
                TextField(
                  controller: txtMaMH,
                  decoration: InputDecoration(labelText: "Mã môn học: "),
                ),
                TextField(
                  controller: txtTenMH,
                  decoration: InputDecoration(labelText: "Tên môn học: "),
                ),
                TextField(
                  controller: txtSoTC,
                  decoration: InputDecoration(labelText: "Số tín chỉ: "),
                ),
                TextField(
                  controller: txtDiemTB,
                  decoration: InputDecoration(labelText: "Điểm trung bình: "),
                ),
                TextField(
                  controller: txtHocKy,
                  decoration: InputDecoration(labelText: "Học kỳ: "),
                ),
                TextField(
                  controller: txtBatBuoc,
                  decoration: InputDecoration(labelText: "Bắt buộc: "),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Hủy")),
            ElevatedButton(
                onPressed: () async {
                  MonHoc mh = MonHoc(
                    maMH: txtMaMH.text,
                    tenMH: txtTenMH.text,
                    soTC: int.parse(txtSoTC.text),
                    diemTB: double.parse(txtDiemTB.text),
                    hocky: int.parse(txtHocKy.text),
                    batBuoc: txtBatBuoc.text
                  );
                  await addMonHocToFirebase(mh);

                  Navigator.pop(context);
                }, child: Text(buttonLabel)),
          ],
        );
      },
    );
  }

  void _showDialogEdit(BuildContext context, MonHocSnapshot mhSnapshot) {
    showDialog(
      context: context,
      builder: (context) {
        txtMaMH.text = mhSnapshot.mh.maMH;
        txtTenMH.text = mhSnapshot.mh.tenMH;
        txtSoTC.text = mhSnapshot.mh.soTC.toString();
        txtDiemTB.text = mhSnapshot.mh.diemTB.toString();
        txtHocKy.text = mhSnapshot.mh.hocky.toString();
        txtBatBuoc.text = mhSnapshot.mh.batBuoc;

        title = "Cập nhật";
        buttonLabel = "Cập nhật";

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(title),
          content: Container(
            width: 130.0,
            height: 220.0,
            child: Column(
              children: [
                TextField(
                  controller: txtMaMH,
                  decoration: InputDecoration(labelText: "Mã môn học: "),
                ),
                TextField(
                  controller: txtTenMH,
                  decoration: InputDecoration(labelText: "Tên môn học: "),
                ),
                TextField(
                  controller: txtSoTC,
                  decoration: InputDecoration(labelText: "Số tín chỉ: "),
                ),
                TextField(
                  controller: txtDiemTB,
                  decoration: InputDecoration(labelText: "Điểm trung bình: "),
                ),
                TextField(
                  controller: txtHocKy,
                  decoration: InputDecoration(labelText: "Học kỳ: "),
                ),
                TextField(
                  controller: txtBatBuoc,
                  decoration: InputDecoration(labelText: "Bắt buộc: "),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Hủy")),
            ElevatedButton(
                onPressed: () async {
                  await mhSnapshot.update(
                      maMH: txtMaMH.text,
                      tenMH: txtTenMH.text,
                      soTC: int.parse(txtSoTC.text),
                      diemTB: double.parse(txtDiemTB.text),
                      hocky: int.parse(txtHocKy.text),
                      batBuoc: txtBatBuoc.text
                  );

                  Navigator.pop(context);
                }, child: Text(buttonLabel)),
          ],
        );
      },
    );
  }

  void _showDialog(MonHocSnapshot data, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc muốn xóa ${data.mh.tenMH} không ?"),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.cancel)),
            ElevatedButton(
                onPressed: () async {
                  await data.delete();
                  Navigator.pop(context);
                },
                child: Icon(Icons.check))
          ],
        );
      },
    );
  }
}
