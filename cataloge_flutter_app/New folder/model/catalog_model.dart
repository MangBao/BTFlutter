import 'dart:ui';
import 'package:flutter/material.dart';

class MatHang{
  int id;
  String name;
  Color color;
  int price;

  MatHang({this.id, this.name, this.color, this.price});
}

List<String> names = ["Táo","Cam","Chuối","Mít","Bưởi","Mận","Đào","Dưa hấu",
  "Xoài","Dừa xiêm","Măng cụt","Sầu riêng","Thơm","Đu đủ"];

class CatalogModel{
  static List<MatHang> matHangs = List.generate(names.length,//generate từ cái list names, index = 0
          (index) => MatHang(
              id: index,
              name: names[index],
              color: Colors.primaries[index % Colors.primaries.length],//dãi màu, mỗi màu cung cấp cho 1 index, chia lấy phần dư
      price: 25)
  );
}