import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monhoc_app/monhoc_page.dart';

class MyFirebaseApp extends StatefulWidget {
  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketNoi = false;
  bool error = false;
  @override
  Widget build(BuildContext context) {
    if (error == true)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Lỗi kết nối!!!", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 18),),
        ),
      );
    else
    if(ketNoi == false)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Đang kết nối...", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 18),),
        ),
      );
    else // Trả về MaterialApp, Provider, ChangeNotifyProvider
      return
        MaterialApp(
          title: "My Firebase App",
          home: MonHocpage(),
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
        error = true;
      });
    }
  }
  @override
  void initState() {
    _initializeFirebase();
    super.initState();
  }
}
