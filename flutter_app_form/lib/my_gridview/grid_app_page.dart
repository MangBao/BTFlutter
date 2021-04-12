import 'package:flutter/material.dart';

import 'gridview_page.dart';

class MyGridViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GridView Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GridViewCountPage(),
    );
  }
}
