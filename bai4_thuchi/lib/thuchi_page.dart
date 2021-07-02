import 'package:bai4_thuchi/thuchi_addpage.dart';
import 'package:bai4_thuchi/thuchi_app.dart';
import 'package:bai4_thuchi/thuchi_editpage.dart';
import 'package:bai4_thuchi/thuchi_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ThuChiPage extends StatefulWidget {
  const ThuChiPage({Key key}) : super(key: key);

  @override
  _ThuChiPageState createState() => _ThuChiPageState();
}

class _ThuChiPageState extends State<ThuChiPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý thu chi"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () =>
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TC_AddPage(),
                ))
          }),


      body: showAllThuChi(context),
    );
  }

  Widget showAllThuChi(BuildContext context) {
    return StreamBuilder<List<ThuChiSnapshot>>(
        stream: getAllFromFirebase(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else {
            var tongthu = 0;
            var tongchi = 0;
            snapshot.data.forEach((e) {
              if(e.thuChi.thuchi == true){
                tongthu += e.thuChi.sotien;
              } else {
                tongchi += e.thuChi.sotien;
              }
            });
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Text(
                      "Thu:" + tongthu.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    Text(
                      "Chi: " + tongchi.toString(),
                      style: TextStyle(fontSize: 20, color: Colors.redAccent),
                    ),
                    Text("Còn: " + (tongthu - tongchi).toString(),
                        style: TextStyle(fontSize: 20, color: Colors.green)),
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
                Row(
                  children: [
                    Text(
                      "Chi tiết thu chi:",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(
                          height: 10,
                        ),
                    itemBuilder: (context, index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: Container(
                          color: snapshot.data[index].thuChi.thuchi == true
                              ? Colors.lightBlue[100]
                              : Colors.pinkAccent[100],
                          child: ListTile(
                            leading:
                            snapshot.data[index].thuChi.thuchi == true
                                ? Icon(
                              Icons.add,
                              size: 50,
                            )
                                : Icon(Icons.remove, size: 50),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${snapshot.data[index].thuChi.lydo} ",
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  "Số tiền: ${snapshot.data[index].thuChi.sotien.toString()}",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.red),
                                ),
                              ],
                            ),
                            subtitle: Text(
                              "Thời gian: " + snapshot.data[index].thuChi.thoigian.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        secondaryActions: [
                          IconSlideAction(
                            caption: "Xóa",
                            icon: Icons.delete,
                            color: Colors.red,
                            onTap: () {
                              showDialogDelete(
                                  snapshot.data[index], context);
                            },
                            closeOnTap: true,
                          ),
                          IconSlideAction(
                            caption: "Cập nhật",
                            icon: Icons.update,
                            color: Colors.green,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  //data[index] là để xác định đúng vị trí của dữ liệu mình cần cập nhật ở trang cập nhật
                                  MaterialPageRoute(
                                      builder: (
                                          context) => TC_EditPage(tcSnapshot: snapshot.data[index]))); //CapNhatThuChiPage(snapshot.data[index])
                            },
                            closeOnTap: true,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
        });
  }

  void showDialogDelete(ThuChiSnapshot data, BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác Nhận"),
          content: Text("Bạn có thật sự  muốn xóa ${data.thuChi.lydo} không ?"),
          actions: [
            ElevatedButton(
              child: Text("Thoát"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Ok"),
              onPressed: () async {
                await data.delete();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
