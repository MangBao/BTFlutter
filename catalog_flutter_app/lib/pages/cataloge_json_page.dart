import 'package:catalog_flutter_app/filehelper/file_helper.dart';
import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:catalog_flutter_app/pages/jsonmathanginfo.dart';
import 'package:catalog_flutter_app/provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CatalogeJsonPage extends StatelessWidget {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  FileHelper fileHelper = new FileHelper();

  @override
  Widget build(BuildContext context) {
    //CatalogeFileProvider fileJsonProvider = context.read()<CatalogeFileProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cataloge"),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatHangInfoPage(indexMH: -1),
                )),
            //Navigator.push(context, route)
          )
        ],
      ),
      body: Consumer<CatalogeFileProvider>(
        builder: (context, catalogeFileProvider, child) =>
            catalogeFileProvider.listMH == null
                ? Center(child: CircularProgressIndicator())
                : buildListMatHang(catalogeFileProvider.listMH),
      ),
    );
  }

  // void _addToJson(BuildContext context) {
  //   // /*ProviderCatalog providerCatalog = context.read<ProviderCatalog>();*/
  //   CatalogeFileProvider fileJsonProvider =
  //       context.read<CatalogeFileProvider>();
  //   MatHang mh = MatHang();
  //   GlobalKey<FormState> _formState = GlobalKey<FormState>();
  //
  //   AlertDialog alertDialog = AlertDialog(
  //     title: Text('Thêm mặt hàng'),
  //     content: Form(
  //       key: _formState,
  //       child: SingleChildScrollView(
  //         // height: 100,
  //         child: Container(
  //           child: Column(
  //             children: [
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     labelText: 'ID',
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)))),
  //                 onSaved: (newValue) {
  //                   mh.id = int.parse(newValue);
  //                 },
  //                 validator: (value) =>
  //                     value.isEmpty ? "Chưa có ID mặt hàng" : null,
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     labelText: 'Name',
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)))),
  //                 onSaved: (newValue) {
  //                   mh.name = newValue;
  //                 },
  //                 validator: (value) =>
  //                     value.isEmpty ? "Chưa có tên mặt hàng" : null,
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               TextFormField(
  //                 decoration: InputDecoration(
  //                     labelText: 'Price',
  //                     border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10)))),
  //                 onSaved: (newValue) {
  //                   mh.price = int.parse(newValue);
  //                 },
  //                 validator: (value) =>
  //                     value.isEmpty ? "Chưa có giá mặt hàng" : null,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //     actions: [
  //       Row(
  //         children: [
  //           TextButton(
  //               onPressed: () {
  //                 if (_formState.currentState.validate()) {
  //                   _formState.currentState.save();
  //                   // providerCatalog.addToCatalog(mh);
  //                   fileJsonProvider.addMatHangs(mh);
  //                   Navigator.pop(context);
  //                 }
  //               },
  //               child: Text('OK')),
  //           TextButton(
  //               onPressed: () => Navigator.pop(context), child: Text('Hủy')),
  //         ],
  //       )
  //     ],
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (context) => alertDialog,
  //   );
  // }

  buildListMatHang(List<MatHang> listMH) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
          itemBuilder: (context, index) =>
              buildListItem(listMH[index], context, index),
          separatorBuilder: (context, index) => Divider(
                thickness: 5,
                color: Colors.white,
              ),
          itemCount: listMH.length),
    );
    // return Center(
    //   child: Text("Tai xong"),
    // );
    //return ListView.separated(itemBuilder: (context, index) => _build, separatorBuilder: (context, index) => Divider(thickness: 5,), itemCount: listMH.length)
  }

  buildListItem(MatHang mh, BuildContext context, int index) {
    return Slidable(
        child: Container(
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                color: mh.color,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(child: Text("${mh.name}"))
            ],
          ),
        ),
        actions: [],
        secondaryActions: [
          IconSlideAction(
            caption: "Xóa",
            icon: Icons.delete_forever,
            color: Colors.red,
            onTap: () => _showDialog(context, mh),
          ),
          IconSlideAction(
            caption: "Cập nhật",
            icon: Icons.update,
            color: Colors.green,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatHangInfoPage(
                    indexMH: index,
                  ) /*null*/,
                )),
          )
        ],
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25);
    // ProviderCatalog providerCatalog = context.read<ProviderCatalog>();
    // CatalogeFileProvider fileJsonProvider = context.read<CatalogeFileProvider>();

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   children: [
    //     Container(
    //       width: 48,
    //       height: 48,
    //       color: mh.color,
    //     ),
    //     SizedBox(
    //       width: 20,
    //     ),
    //     Expanded(
    //         child: Text(
    //           "${mh.name}",
    //           style: TextStyle(fontSize: 20),
    //         )),
    //     TextButton(
    //       onPressed: () => fileJsonProvider.addMatHangs(mh),
    //       child: fileJsonProvider.readMatHangs() != null
    //           ? Icon(Icons.check)
    //           : Text("Add"),
    //     ),
    //     SizedBox(
    //       width: 15,
    //     ),
    //   ],
    // );
  }

  _showDialog(BuildContext context, MatHang mh) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: Text("Ban chac muon xoa ${mh.name}?"),
        actions: [
          FlatButton(
              onPressed: () => Navigator.pop(context), child: Text("Hủy")),
          FlatButton(
              onPressed: () {
                CatalogeFileProvider cfp = context.read<CatalogeFileProvider>();
                cfp.removeMatHangs(mh);
                Navigator.pop(context);
              },
              child: Text("Ok")),
        ],
      ),
    );
  }
}
