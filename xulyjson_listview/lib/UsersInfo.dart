import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class FileHelper {
  String fileName;

  FileHelper({this.fileName});

  String initialContent(); // Phương thức trừu tượng sẽ được implement ở các lớp

  Future<String> get _localPath async {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    String path = await _localPath;
    return File('$path/$fileName');
  }

  Future<File> writeString(String str) async {
    File file = await _localFile;
    return file.writeAsString(str);
  }

  Future<String> readFile() async {
    try {
      File file = await _localFile;
      if (!file.existsSync()) {
        print('file chưa tồn tại: ${file.absolute}');
        await file.writeAsString(initialContent());
      }
      String content = await file.readAsString();
      return content;
    } catch (e) {
      print('Lỗi khi đọc file');
      return null;
    }
  }
}

//lớp User
class User {
  String name, email;

  User({this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email};
  }
}
Future<List<User>> fetchUserFromJson(String path) async {
  String userJson = await rootBundle.loadString(path);
  List<dynamic> list = jsonDecode(userJson) as List;
  return list.map((user) => User.fromJson(user)).toList();
}


const String infoUser = "data/users.json";

class FileProfileHelper extends FileHelper {
  FileProfileHelper() : super(fileName: infoUser);

  @override
  String initialContent() {
    return "{'profile':{}}";
  }
}



class UsersInfor extends StatefulWidget {
  @override
  _UsersInforState createState() => _UsersInforState();
}

class ProfileDatabase extends ChangeNotifier{
  User _user;
  FileProfileHelper fileHelper = FileProfileHelper();


  ProfileDatabase(){
    _user = User(
        name: "Bao",
      email: "mangbao1301@gmail.com"
    );
  }
  User get profile => _user;
  void readProfile() async{
    String content = await fileHelper.readFile();
    Map data = json.decode(content)['user'];
    if(data.isNotEmpty) {
      _user = User.fromJson(data);
      notifyListeners();
    }
  }
  void updateProfile(User newUser) async{
    _user = newUser;
    notifyListeners();
    String content = json.encode(newUser);
    await fileHelper.writeString(content);
  }
}

class _UsersInforState extends State<UsersInfor> {
  User _user;

  ProfileDatabase pbd = ProfileDatabase();

  @override
  Widget build(BuildContext context) {
    String path = "data/users.json";
    return Scaffold(
      appBar: AppBar(
        title: Text('User From Json'),
      ),
      body: FutureBuilder<List<User>>(
          initialData: [],
          future: fetchUserFromJson(path),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(child: Text("Lỗi xảy ra"));
            else
              return snapshot.hasData
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'name: ${snapshot.data[index].name}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('email: ${snapshot.data[index].email}'),
                                ],
                              ),
                          separatorBuilder: (context, index) => Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                          itemCount: snapshot.data.length),
                    )
                  : Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: ElevatedButton(
          /*onPressed: () => _toEditPage(context),*/
          child: Text("Chỉnh sửa")),
    );
  }

}
