import 'package:flutter/material.dart';

import 'model.dart';

class GridViewCountPage extends StatelessWidget {
  List<Product> list;

  @override
  Widget build(BuildContext context) {
    list = List.generate(
        100, (index) => Product(id: index + 1, name: "Product ${index + 1}"));
    return Scaffold(
      appBar: AppBar(
        title: Text("GridView Demo"),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 150,
        padding: EdgeInsets.all(5),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: list.map((e) => Card(
          child: Center(child: Text(e.name),),
        )).toList(),

      ),
      // body: GridView.count(
      //   crossAxisCount: 6,
      //   children: list
      //       .map((e) => Card(
      //             child: Center(
      //               child: Text(e.name),
      //             ),
      //           ))
      //       .toList(),
      // ),
    );
  }
}
