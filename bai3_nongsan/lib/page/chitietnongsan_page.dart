import 'package:bai3_nongsan/model/giohang_model.dart';
import 'package:bai3_nongsan/model/nongsan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'giohang_page.dart';

class CT_NongSanPage extends StatefulWidget {
  final NongSanSnapshot nongSanSnapshot;

  const CT_NongSanPage({Key key, this.nongSanSnapshot}) : super(key: key);

  @override
  _CT_NongSanPageState createState() => _CT_NongSanPageState();
}

class _CT_NongSanPageState extends State<CT_NongSanPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giải cứu nông sản"),
        actions: [
          StreamBuilder<List<GioHangSnapshot>>(
            stream: getGioHangFromFirebase(),
            builder: (context, snapshot) {
              return GestureDetector(
                //Một tiện ích phát hiện cử chỉ
                //toàn bộ bấm zô đc hết
                child: Stack(
                  alignment: Alignment.center, //cái sau đề cái trước ở chính giữa
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.shopping_cart,
                        size: 48,
                        color: Colors.red,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 11, right: 20),
                      child: Text("${snapshot.data.length}", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            GioHangPage(), //hàm đầu vào là context, đầu ra
                      ));
                },
              );
            }
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.nongSanSnapshot.nongSan.anhns),
              Text(
                widget.nongSanSnapshot.nongSan.tenns,
                style: TextStyle(fontSize: 25, color: Colors.blueAccent),
              ),
              Text(
                widget.nongSanSnapshot.nongSan.mota,
                style: TextStyle(fontSize: 18),
              ),
              Text(
                widget.nongSanSnapshot.nongSan.gia.toString() + "/kg",
                style: TextStyle(color: Colors.redAccent, fontSize: 25),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.lightBlue,
                    child: IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.add_shopping_cart),
                        onPressed: () async {
                          GioHang gioHang = GioHang(
                              tenns: widget.nongSanSnapshot.nongSan.tenns,
                              soluong: 1,
                              gia: widget.nongSanSnapshot.nongSan.gia,
                              anhns: widget.nongSanSnapshot.nongSan.anhns);

                          var kt_sp = 0;
                          var gio_hangsnapshot = await FirebaseFirestore.instance.collection('GioHang').get();
                          gio_hangsnapshot.docs.forEach((doc) =>
                          {
                            if (doc['tenns'] == gioHang.tenns) kt_sp++
                          });

                          if (kt_sp == 0) {
                            await addToGioHangFirebase(gioHang);
                            kt_sp = 0;
                            showNotificationAdd(context);
                          } else
                            showNotificationExist(context);
                        }),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void showNotificationAdd(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông Báo"),
            content: Text("Đã thêm sản phẩm thành công"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  void showNotificationExist(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông báo"),
            content: Text("Sản phẩm đã có trong giỏ hàng"),
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
