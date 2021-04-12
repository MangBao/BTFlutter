import 'package:flutter/material.dart';
import 'package:flutter_app_form/my_listview/listview_page.dart';

class MyListViewApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GridView Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListViewSeparated(),
    );
  }
}
