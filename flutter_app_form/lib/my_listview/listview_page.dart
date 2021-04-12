import 'package:flutter/material.dart';
import 'package:flutter_app_form/my_gridview/model.dart';

class ListViewBuilderPage extends StatelessWidget {
  List<Product> list;

  // ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
  //   title: Text(title, style: TextStyle(
  //     fontWeight: FontWeight.w500,
  //     fontSize: 20,
  //   ),),
  //   subtitle: Text(subtitle),
  //   leading: Icon(
  //     icon,
  //     color: Colors.blue[500],
  //   ),
  // );

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     _tile('CineArts at the Empire', '85W Portal Ave', Icons.theaters)
    //   ],
    // );
    List<Product> list = List.generate(
        100, (index) => Product(id: index + 1, name: "Home num: ${index + 1}"));

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: Icon(Icons.home),
          title: Text(
            list[index].name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Phone: 0372978074"),
        ),
      ),
    );
  }
}

class ListViewSeparated extends StatelessWidget {
  List<Product> list = List.generate(100,
      (index) => Product(id: index + 1, name: "Recycle Bin num: ${index + 1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Demo"),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Colors.pink,
                ),
            title: Text(list[index].name),
            subtitle: Text("Phone: 123456789"),
              ),
          separatorBuilder: (context, index) => Divider(
                thickness: 2,
                color: Colors.grey,
              ),
          itemCount: list.length),
    );
  }
}
