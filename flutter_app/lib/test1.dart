import 'package:flutter/material.dart';
import 'package:flutter_app/profile_app.dart';

class MyProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Profile App",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: ProfilePage(),

    );
  }
}

