import 'dart:convert';
import 'dart:io';


import 'package:catalog_flutter_app/filehelper/file_helper.dart';
import 'package:catalog_flutter_app/model/cataloge_model.dart';
import 'package:flutter/material.dart';

class CatalogeFileProvider extends ChangeNotifier{
  MatHangDatabase _matHangDatabase;
  FileHelper _fileHelper = FileHelper();
  CatalogeFileProvider();

  List<MatHang> get listMH => _matHangDatabase == null ? null : _matHangDatabase.listMH;

  Future<void>readMatHangs()async {
    String contents = await _fileHelper.readString();
    if(contents != null){
      //chuyen contents thanh dt Map<String, dynamic>
      var jsonstr = json.decode(contents);
      _matHangDatabase = MatHangDatabase.fromJson(jsonstr);
      print("So luong mat hang: ${_matHangDatabase.listMH.length}");
      notifyListeners();
    }
  }

  Future<File> updateMatHangs() async {
    notifyListeners();
    String content = json.encode(_matHangDatabase);
    return _fileHelper.writeString(content);
  }

  Future<File> addMatHangs(MatHang mh) async {
    listMH.add(mh);
    notifyListeners();
    String content = json.encode(_matHangDatabase);
    return _fileHelper.writeString(content);
  }

  Future<File> removeMatHangs(MatHang mh) async {
    listMH.remove(mh);
    notifyListeners();
    String content = json.encode(_matHangDatabase);
    return _fileHelper.writeString(content);
  }
}