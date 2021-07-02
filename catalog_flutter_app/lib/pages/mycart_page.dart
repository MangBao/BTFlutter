import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:catalog_flutter_app/provider/cataloge_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    //List<MatHang> mh;
    ProviderCatalog providerCatalog = context.watch<ProviderCatalog>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: showListMatHang(context, providerCatalog.gioHang),
      //khai baos list mat hang
      floatingActionButton: TextButton(
        onPressed: () => null,
        child: Text('${providerCatalog.total} Buy',style: TextStyle(fontSize: 40, color: Colors.red[300]),),
      ),

    );
  }

  Widget showListMatHang(BuildContext context, List<MatHang> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: ListView.separated(
            itemBuilder: (context, index) => showListItem(list[index], context),
            separatorBuilder: (context, index) => Divider(
                  thickness: 5,
                  color: Colors.white,
                ),
            itemCount: list.length),
      ),
    );
  }

  showListItem(MatHang mh, BuildContext context) {
    ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 30,
          height: 50,
        ),
        Icon(
          Icons.check,
          color: Colors.blue,
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          width: 48,
          height: 48,
          color: mh.color,
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
            child: Text(
          "${mh.name}",
          style: TextStyle(fontSize: 20),
        )),
        TextButton(
          onPressed: () => providerCatalog.removeFromCart(mh),
          child: Icon(Icons.remove_circle),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
