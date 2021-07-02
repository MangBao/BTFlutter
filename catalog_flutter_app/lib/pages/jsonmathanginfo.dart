import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:catalog_flutter_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MatHangInfoPage extends StatefulWidget {
  int indexMH = 1;
  MatHangInfoPage({this.indexMH});
  @override
  _MatHangInfoPageState createState() => _MatHangInfoPageState();
}

class _MatHangInfoPageState extends State<MatHangInfoPage> {
  final _formKey = GlobalKey<FormState>();
  int _indexMH;
  @override
  Widget build(BuildContext context) {
    MatHang matHang = _indexMH == -1 ? MatHang() : context.watch<CatalogeFileProvider>().listMH[_indexMH];
    return Scaffold(
      appBar: AppBar(
        title: Text("Mặt hàng"),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: matHang.id == null ? null : matHang.id.toString(),
                decoration: InputDecoration(
                  labelText: "Id",
                  hintText: "Nhập ID của mặt hàng",
                ),
                keyboardType: TextInputType.number,
                onSaved: (newValue) => matHang.id = int.parse(newValue),
                validator: (value) => value.isEmpty ? "id không được để trống" : null,
              ),
              TextFormField(
                initialValue: matHang.name == null ? null : matHang.name.toString(),
                decoration: InputDecoration(
                  labelText: "Tên mặt hàng",
                  hintText: "Nhập tên của mặt hàng",
                ),
                keyboardType: TextInputType.text,
                onSaved: (newValue) => matHang.name = newValue,
                validator: (value) => value.isEmpty ? "tên không được để trống" : null,
              ),
              TextFormField(
                initialValue: matHang.price == null ? null : matHang.price.toString(),
                decoration: InputDecoration(
                  labelText: "Giá mặt hàng",
                  hintText: "Nhập giá của mặt hàng",
                ),
                keyboardType: TextInputType.number,
                onSaved: (newValue) => matHang.price = int.parse(newValue),
                validator: (value) => value.isEmpty ? "giá không được để trống" : null,
              ),
              RaisedButton(onPressed: () =>  _save(context, matHang), child: Text("Ok"),),
              RaisedButton(onPressed: () =>  Navigator.pop(context), child: Text("Hủy"),),
            ],
          ),
        ),
      ),
    );

  }
  @override
  void initState(){
    super.initState();
    _indexMH = widget.indexMH;
  }
  _save(BuildContext context, MatHang matHang){
    if(_formKey.currentState.validate() == true){
      _formKey.currentState.save();
      CatalogeFileProvider catalogeFileProvider = context.read<CatalogeFileProvider>();
      if(_indexMH == -1){
        matHang.color = Colors.primaries[matHang.id % Colors.primaries.length];
        catalogeFileProvider.addMatHangs(matHang);
      }
      else{
        catalogeFileProvider.updateMatHangs();
      }
      Navigator.pop(context);
    }
  }
}
