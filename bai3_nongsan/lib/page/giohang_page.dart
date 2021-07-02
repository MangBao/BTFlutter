import 'package:bai3_nongsan/model/giohang_model.dart';
import 'package:bai3_nongsan/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class GioHangPage extends StatefulWidget {
  const GioHangPage({Key key}) : super(key: key);

  @override
  _GioHangPageState createState() => _GioHangPageState();
}

class _GioHangPageState extends State<GioHangPage> {
  UserSnapshot userSnapshot;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng"),
      ),
      body: showAllCart(context),
    );
  }

  Widget showAllCart(BuildContext context) {
    int tongTien = 0;
    int tong = 0;
    return StreamBuilder<List<GioHangSnapshot>>(
      stream: getGioHangFromFirebase(),
      builder: (context, snapshot) {
        snapshot.data.forEach((element) {
          tongTien = element.gioHang.gia * element.gioHang.soluong;
          tong += tongTien;
        });
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              khachHang(context),
              SizedBox(
                height: 20,
              ),

              Text("Giỏ hàng:", style: TextStyle(fontSize: 20)),
              Expanded(
                child: ListView.separated(
                  itemCount: snapshot.data.length,
                  separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Xóa',
                          color: Colors.red,
                          icon: Icons.delete_forever,
                          onTap: () =>
                              showDialogDelete(snapshot.data[index], context),
                          closeOnTap: true,
                        ),
                      ],
                      child: Column(
                        children: [
                          ListTile(
                            leading: Image.network(
                                snapshot.data[index].gioHang.anhns),
                            trailing: Text(
                              snapshot.data[index].gioHang.gia.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                            title: Text(
                              snapshot.data[index].gioHang.tenns,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  snapshot.data[index].update(
                                      soluong: snapshot.data[index].gioHang.soluong - 1,
                                      tenns: snapshot.data[index].gioHang.tenns,
                                      anhns: snapshot.data[index].gioHang.anhns,
                                      gia: snapshot.data[index].gioHang.gia);
                                },
                              ),
                              Text(snapshot.data[index].gioHang.soluong
                                  .toString()),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  snapshot.data[index].update(
                                      soluong: snapshot.data[index].gioHang.soluong + 1,
                                      tenns: snapshot.data[index].gioHang.tenns,
                                      anhns: snapshot.data[index].gioHang.anhns,
                                      gia: snapshot.data[index].gioHang.gia);
                                },
                              ),
                              Expanded(
                                  child: Text(
                                "Tổng: " + ((snapshot.data[index].gioHang.soluong) * (snapshot.data[index].gioHang.gia)).toString(),
                                style: TextStyle(fontSize: 20, color: Colors.red),
                              ))
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Tổng tiền: ${tong}",
                          style: TextStyle(fontSize: 30, color: Colors.red)),
                      RaisedButton(
                        child: Text('Đặt hàng'),
                        color: Colors.blue,
                        onPressed: () => null,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget khachHang(BuildContext context) {
    return FutureBuilder<UserSnapshot>(
        future: UserSnapshot().getUserFromFirebaseByID('9SA96wdvXPnbLnWa1b9J'),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Khách hàng: ${snapshot.data.user.ten}",
                    style: TextStyle(fontSize: 20)),
                Text("Địa chỉ: ${snapshot.data.user.diachi}",
                    style: TextStyle(fontSize: 20)),
                Text("Số điện thoại: ${snapshot.data.user.sdt}",
                    style: TextStyle(fontSize: 20)),
              ],
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }

  void showDialogDelete(GioHangSnapshot data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Xác nhận"),
            content:
                Text("Bạn có muốn xóa sản phảm '${data.gioHang.tenns}' không?"),
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
