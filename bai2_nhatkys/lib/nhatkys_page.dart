import 'package:bai2_nhatkys/nhatkys_add_page.dart';
import 'package:bai2_nhatkys/nhatkys_edit_page.dart';
import 'package:bai2_nhatkys/nhatkys_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NhatKysPage extends StatefulWidget {
  @override
  _NhatKysPageState createState() => _NhatKysPageState();
}

class _NhatKysPageState extends State<NhatKysPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        shape: CircularNotchedRectangle(),
        child: Row(
          children: [
            Text(".",style: TextStyle(fontSize: 40,color: Colors.lightBlue),)
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Nhật ký"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NK_AddPage(), //Thêm môn học mới
              ))
        },
        child: Icon(Icons.add),
      ),
      body: Center(child: showAllNhatKy(context)),
    );
  }

  Widget showAllNhatKy(BuildContext context) {
    return StreamBuilder<List<NhatKySnapshot>>(
      stream: getAllFromFirebase(),
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
                actions: [],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Cập nhật',
                    color: Colors.lightBlue[600],
                    icon: Icons.update,
                    onTap: () {
                      //Chuyển trang để cập nhật dữ liệu
                      Navigator.push(
                          context,
                          //data[index] là để xác định đúng vị trí của dữ liệu mình cần cập nhật ở trang cập nhật
                          MaterialPageRoute(
                              builder: (context) => NK_EditPage(
                                  nkSnapshot: snapshot.data[index])));
                    },
                    /*onTap: () => showDialogEdit(context, snapshot.data[index]),*/
                    closeOnTap: true,
                  ),
                  IconSlideAction(
                    caption: 'Xóa',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () =>
                        showDialogDelete(snapshot.data[index], context),
                    closeOnTap: true,
                  ),
                ],
                child: ListTile(
                  leading: Column(
                    children: [
                      Text(
                        snapshot.data[index].nhatKy.day,
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snapshot.data[index].nhatKy.weekday,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      )
                    ],
                  ),
                  title: Text(
                    snapshot.data[index].nhatKy.date,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index].nhatKy.mood,
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      ),
                      Text(
                        snapshot.data[index].nhatKy.note,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  void showDialogDelete(NhatKySnapshot data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Xác nhận"),
            content:
                Text("Bạn có  muốn xóa nhật ký vào ${data.nhatKy.date} không?"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () async {
                  await data.delete();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Thoát"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
