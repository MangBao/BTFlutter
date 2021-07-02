import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:catalog_flutter_app/pages/mycart_page.dart';
import 'package:catalog_flutter_app/provider/cataloge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StaffPage extends StatefulWidget {
  @override
  _StaffPageState createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  Widget build(BuildContext context) {
    ProviderCatalog providerCatalog = context.watch<ProviderCatalog>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAlertAddItem(context),
          ),
        ],
      ),
      body: buildListMatHang(
          context, providerCatalog.cataloge), //khai baos list mat hang
      //floatingActionButton:
    );
  }

  Widget buildListMatHang(BuildContext context, List<MatHang> list) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) => buildListItem(list[index], context),
          separatorBuilder: (context, index) => Divider(
                thickness: 5,
                color: Colors.white,
              ),
          itemCount: list.length),
    );
  }

  void _showAlertAddItem(BuildContext context) {
    ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
    MatHang mh = MatHang();
    GlobalKey<FormState> _formState = GlobalKey<FormState>();

    AlertDialog alertDialog = AlertDialog(
      title: Text('Thêm mặt hàng'),
      content: Form(
        key: _formState,
        child: Container(
          height: 70,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onSaved: (newValue) {
                  mh.name = newValue;
                },
                validator: (value) =>
                    value.isEmpty ? "Chưa có tên mặt hàng" : null,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            TextButton(
                onPressed: () {
                  if (_formState.currentState.validate()) {
                    _formState.currentState.save();
                    providerCatalog.addToCatalog(mh);
                    Navigator.pop(context);
                  }
                },
                child: Text('OK')),
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Hủy')),
          ],
        )
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}

buildListItem(MatHang mh, BuildContext context) {
  ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
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
        onPressed: () => providerCatalog.removeProduct(mh),
        child: Icon(Icons.remove_circle),
      ),
      SizedBox(
        width: 15,
      ),
    ],
  );
}
