import 'package:bai1_qlmh/models/mon_hoc.dart';
import 'package:bai1_qlmh/pages/mon_hoc_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MonHocCheck extends StatefulWidget {
  const MonHocCheck({Key key}) : super(key: key);

  @override
  _MonHocCheckState createState() => _MonHocCheckState();
}

class _MonHocCheckState extends State<MonHocCheck> {
  MonHoc mh;
  bool ketNoi = false;
  bool err = false;

  @override
  Widget build(BuildContext context) {
    if (err == true) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Loi ket noi",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else if (ketNoi == false) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Dang ket noi...",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else
      return MaterialApp(
        title: "My Firebase App",
        home: Scaffold(
            appBar: AppBar(
              title: Text("My Firebase App"),
            ),
            body: MonHocPage()
        ),
        theme: ThemeData(primarySwatch: Colors.lightBlue, visualDensity: VisualDensity.adaptivePlatformDensity),
      );
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } catch (e) {
      setState(() {
        err = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    super.initState();
  }
}
