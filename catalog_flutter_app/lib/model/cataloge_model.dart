import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class MatHang{
  int id;
  String name;
  Color color;
  int price;

  MatHang({this.id, this.name, this.color, this.price});

  //Day la phan them vao
  factory MatHang.fromJson(Map<String, dynamic> json){
    int colorIndex = json['color'] as int;
    return MatHang( //tra ve doi tuong mathang, nhan vao cau truc map
      id: json['id'] as int,
      name: json['name'] as String,
      color: Colors.primaries[colorIndex],
      price: json['price'] as int
    );
    //co the ep kieu or ko
  }
  Map<String, dynamic> toJson(){ //chuyen doi tuong mathang thanh cau truc map
    return{
      'id': id,
      'name': name,
      'color': Colors.primaries.indexOf(color),
      'price': price
    };
  }
  //Het phan them vao
}
// var json = {
// "mat_hangs" :[
// {"id": "1", "name": "Táo", "color": "", "price": "25"}
// ]
// };
//Day la phan them vao
class MatHangDatabase{
  List<MatHang> listMH;

  MatHangDatabase(this.listMH);
  factory MatHangDatabase.fromJson(Map<String, dynamic> json){
    var list = json["mat_hangs"] as List;
    return MatHangDatabase(list.map((e) => MatHang.fromJson(e)).toList());
  }

  Map<String, dynamic> toJson(){
    return {
      "mat_hangs" : List<dynamic>.from(listMH.map((e) => e.toJson()))
    }; // tra ve mot cau truc Json
  }
}
//Het phan them vao

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

