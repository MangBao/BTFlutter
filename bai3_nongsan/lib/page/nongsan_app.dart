import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dangnhap_page.dart';

class NongSanApp extends StatefulWidget {
  @override
  _NongSanAppState createState() => _NongSanAppState();
}

class _NongSanAppState extends State<NongSanApp> {
  bool ketNoi = false;
  bool err = false;

  @override
  Widget build(BuildContext context) {
    if (err == true)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Lỗi kết nối!!!",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    else if (ketNoi == false)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Đang kết nối...",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    else // Trả về MaterialApp, Provider, ChangeNotifyProvider
      return MaterialApp(
        title: "My Firebase App",
        home: DangNhapPage(),
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
    _initializeFirebase();
    super.initState();
  }
}
