import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileHelper{
  String _fileName = "mathangs.json";

  //Lay path thu muc ung dung
  Future<String> get _localPath async{
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  //tao tham chieu den tap tin
  Future<File> get _localFile async{
    String path = await _localPath;
    return File("$path/$_fileName");
  }

  //ghi noi dung vao file
  Future<File> writeString(String content)async{
    File file = await _localFile;
    return file.writeAsString(content);
  }

  //doc noi dung tu tap tin
  Future<String> readString() async{
    try{
      File file = await _localFile;
      if(!file.existsSync()){
        print('file chua ton tai: ${file.absolute}');
        await file.writeAsString('{"mat_hangs" :[]}', encoding: Utf8Codec());
      }
      String content = await file.readAsString(encoding: Utf8Codec());
      return content;
    }
    catch(e){
      print("Loi khi doc file: $e");
      return null;
    }

  }
}