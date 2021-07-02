import 'package:flutter/material.dart';
import 'package:flutter_app/profile_app.dart';

class myProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Profile",
      theme: ThemeData(primarySwatch: Colors.orange),
      home: Profile_App(),
    );
  }
}