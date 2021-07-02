import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_app/model/user.dart';
import 'package:my_firebase_app/pages/user_page.dart';

/*
* 1. hiển thị trạng thái đang kết nối
* 2. hiển thị trang ứng dụng nếu kết nối thành công
* 3. Hiển thị lỗi nếu kết nối thất bại
*/

/*class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key key}) : super(key: key);

  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  User userProfile;
  bool ketNoi = false;
  bool err = false;

  @override
  Widget build(BuildContext context) {
    if (err == true) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Loi ket noi",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else if (ketNoi == false) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "Dang ket noi...",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    } else
      return MaterialApp(
        title: "My firebase app",
        home: Scaffold(
          appBar: AppBar(
            title: Text("My Firebase App"),
          ),
          body: UserPage()
        ),
        theme: ThemeData(primarySwatch: Colors.orange, visualDensity: VisualDensity.adaptivePlatformDensity),
      );
  }

  *//*Widget _streamWidget(BuildContext context) {
    return StreamBuilder<UserSnapshot>(
      stream: UserSnapshot.getDocFromFireeBase("ElmqJbbKne1kp8sNhSZh"),
      builder: (context, userSnapshot) {
        if (!userSnapshot.hasData) {
          return Text("No data");
        } else {
          return Scaffold(
            body: Column(
              children: [
                Text("Họ và tên: ${userSnapshot.data.user.ten}"),
                Text("Năm sinh: ${userSnapshot.data.user.nam_sinh}"),
                Text("Quê quán: ${userSnapshot.data.user.que_quan}"),
              ],
            ),
          );
        }
      },
    );
  }*//*

  *//*Widget _futureWidget(BuildContext context) {
    return FutureBuilder<UserSnapshot>(
      future: UserSnapshot().getUserFromFireBaseByID("ElmqJbbKne1kp8sNhSZh"),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData)
          return Text("${userSnapshot.data.user.ten}");
        else
          return Text("Khong co du lieu");
      },
    );
  }*//*

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } catch (e) {
      setState(() {
        err = true;
      });
    }
  }

  *//*Widget _allUser(BuildContext context) {
    return StreamBuilder<List<UserSnapshot>>(
      stream: getAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              thickness: 2,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Cập nhật',
                    color: Colors.green,
                    icon: Icons.update,
                    onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => null)),
                    closeOnTap: true,
                  ),
                  IconSlideAction(
                    caption: 'Xóa',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () {
                      _showDialog(snapshot.data[index], context);
                    },
                  ),
                ],
                child: ListTile(
                  leading: Icon(Icons.face_sharp),
                  title: Text(
                    snapshot.data[index].user.ten,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(snapshot.data[index].user.que_quan),
                  trailing: Text(
                    '${snapshot.data[index].user.nam_sinh}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }*//*

  *//*void _toEditPage(BuildContext context) async {
    //nhận đối số BuildContext context
    var updateProfile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditPage(
              userProfile: this.userProfile), //hàm đầu vào là context, đầu ra
        ));
    if (updateProfile != null)
      setState(() {
        userProfile = updateProfile;
      });
  }*//*

  @override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    super.initState();
  }

  *//*TextEditingController txtAddName = TextEditingController();
  TextEditingController txtAddNamSinh = TextEditingController();
  TextEditingController txtAddQueQuan = TextEditingController();

  void _showDialogAdd(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Them user"),
          content: Column(
            children: [
              TextField(
                controller: txtAddName,
                decoration: InputDecoration(labelText: "Ten: "),
              ),
              TextField(
                controller: txtAddNamSinh,
                decoration: InputDecoration(labelText: "Nam sinh: "),
              ),
              TextField(
                controller: txtAddQueQuan,
                decoration: InputDecoration(labelText: "Que quan: "),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Huy")),
            ElevatedButton(
                onPressed: () async {
                  User user = User(
                    ten: txtAddName.text,
                    que_quan: txtAddQueQuan.text,
                    nam_sinh: int.parse(txtAddNamSinh.text)
                  );
                  await addUserToFirebase(user);
                  Navigator.pop(context);
                }, child: Text("Them")),
          ],
        );
      },
    );
  }

  void _showDialog(UserSnapshot data, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xac nhan"),
          content: Text("Ban co chac muon xoa ${data.user.ten} không ?"),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.cancel)),
            ElevatedButton(
                onPressed: () async {
                  await data.delete();
                  Navigator.pop(context);
                },
                child: Icon(Icons.check))
          ],
        );
      },
    );
  }*//*
}*/
//bai cua Long
class MyFirebaseApp extends StatefulWidget {
  @override
  _MyFirebaseAppState createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketNoi = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    if (error == true)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Lỗi kết nối!!!", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 18),),
        ),
      );
    else
    if(ketNoi == false)
      return Container(
        color: Colors.white,
        child: Center(
          child: Text("Đang kết nối...", textDirection: TextDirection.ltr, style: TextStyle(fontSize: 18),),
        ),
      );
    else // Trả về MaterialApp, Provider, ChangeNotifyProvider
      return
        MaterialApp(
          title: "My Firebase App",
          home: Userpage(),
        );
  }
  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketNoi = true;
      });
    } catch (e) {
      setState(() {
        error = true;
      });
    }
  }
  @override
  void initState() {
    _initializeFirebase();
    super.initState();
  }
}
