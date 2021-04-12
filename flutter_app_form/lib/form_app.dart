import 'package:flutter/material.dart';

class MyFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form_App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyForm(),
    );
  }
}

class MatHang {
  String tenMH, loaiMH;
  int soLuong;

  MatHang({this.tenMH, this.loaiMH, this.soLuong});
}

//khai báo toàn cục
List<String> loaiMHs = ['Tivi', 'Điện thoại', 'Laptop'];

class MyForm extends StatelessWidget {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  MatHang mh = MatHang();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Form App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Mặt hàng',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                onSaved: (newValue) {
                  mh.tenMH = newValue;
                },
                validator: (value) =>
                    value.isEmpty ? "Chưa có tên mặt hàng" : null,
              ),

              SizedBox(
                height: 10,
              ),
              //----------------------------------------------------
              DropdownButtonFormField<String>(
                items: loaiMHs
                    .map((loaiMH) => DropdownMenuItem<String>(
                          child: Text(loaiMH),
                          value: loaiMH,
                        ))
                    .toList(),
                onChanged: (value) {
                  mh.loaiMH = value;
                },
                validator: (value) =>
                    value == null ? "Chưa chọn loại mặt hàng" : null,
                decoration: InputDecoration(
                    labelText: 'Loại mặt hàng',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),

              SizedBox(
                height: 10,
              ),
              //----------------------------------------------------
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Số lượng',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),

                //chuyển bàn phím sang số
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),

                onSaved: (newValue) {
                  mh.soLuong = int.parse(newValue);
                },
                validator: (value) =>
                    value.isEmpty ? "Chưa nhập số lượng" : null,
              ),
              //tạo nút bấm
              Row(
                children: [
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  // ignore: deprecated_member_use
                  RaisedButton(
                    child: Text('OK'),
                    color: Colors.white,
                    onPressed: () {
                      if (_formState.currentState.validate()) {
                        _formState.currentState.save();
                        _showAlertDialog(context);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: Text('Xác nhận'),
      content: Text("Bạn nhập mặt hàng: ${mh.tenMH}\n"
          "Thuộc loại mặt hàng: ${mh.loaiMH}\n"
          "Với số lượng: ${mh.soLuong}"),
      actions: [
        // ignore: deprecated_member_use
        FlatButton(onPressed: () => Navigator.pop(context), child: Text('Ok'))
      ],
    );
    showDialog(
      context: context,
      builder: (context) => alertDialog,
    );
  }
}
