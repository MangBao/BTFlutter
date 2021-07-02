import 'package:flutter/material.dart';
import 'package:my_firebase_app/pages/my_app.dart';

class myProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Profile",
      theme: ThemeData(primarySwatch: Colors.orange),
      home: MyFirebaseApp(),
    );
  }
}