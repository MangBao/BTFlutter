import 'package:flutter/material.dart';

import 'mon_hoc_check.dart';

class MonHocApp extends StatelessWidget {
  const MonHocApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quan ly mon hoc",
      theme: ThemeData(primarySwatch: Colors.red),
      home: MonHocCheck(),
    );
  }
}
