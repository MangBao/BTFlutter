import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_app/model/user.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/*class UserPage extends StatefulWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  *//*User userProfile;
  bool ketNoi = false;
  bool err = false;*//*
  String title = "";
  String buttonLabel = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _allUser(context),
      floatingActionButton: Row(
        children: [
          Expanded(child: SizedBox()),
          ElevatedButton(
              onPressed: () => _showDialogAdd(context),
              child: Icon(Icons.add)),
          SizedBox(height: 10),
        ],
      ),
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

  *//*Future<void> _initializeFirebase() async {
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
  }*//*

  Widget _allUser(BuildContext context) {
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
                    onTap: () => _showDialogEdit(context, snapshot.data[index]),
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
  }

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

  *//*@override
  void initState() {
    // TODO: implement initState
    _initializeFirebase();
    super.initState();
  }*//*

  TextEditingController txtAddName = TextEditingController();
  TextEditingController txtAddNamSinh = TextEditingController();
  TextEditingController txtAddQueQuan = TextEditingController();

  void _showDialogAdd(BuildContext context) {
    title = "Thêm user";
    buttonLabel = "Thêm";
    txtAddName.clear();
    txtAddQueQuan.clear();
    txtAddNamSinh.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(title),
          content: Container(
            width: 130.0,
            height: 220.0,
            child: Column(
              children: [
                TextField(
                  controller: txtAddName,
                  decoration: InputDecoration(labelText: "Tên: "),
                ),
                TextField(
                  controller: txtAddNamSinh,
                  decoration: InputDecoration(labelText: "Năm sinh: "),
                ),
                TextField(
                  controller: txtAddQueQuan,
                  decoration: InputDecoration(labelText: "Quê quán: "),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Hủy")),
            ElevatedButton(
                onPressed: () async {
                  User user = User(
                      ten: txtAddName.text,
                      que_quan: txtAddQueQuan.text,
                      nam_sinh: int.parse(txtAddNamSinh.text)
                  );
                  await addUserToFirebase(user);

                  Navigator.pop(context);
                }, child: Text(buttonLabel)),
          ],
        );
      },
    );
  }

  void _showDialogEdit(BuildContext context, UserSnapshot userSnapshot) {
    showDialog(
      context: context,
      builder: (context) {
        txtAddName.text = userSnapshot.user.ten;
        txtAddQueQuan.text = userSnapshot.user.que_quan;
        txtAddNamSinh.text = userSnapshot.user.nam_sinh.toString();
        title = "Cập nhật";
        buttonLabel = "Cập nhật";

        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          title: Text(title),
          content: Container(
            width: 130.0,
            height: 220.0,
            child: Column(
              children: [
                TextField(
                  controller: txtAddName,
                  decoration: InputDecoration(labelText: "Tên: "),
                ),
                TextField(
                  controller: txtAddNamSinh,
                  decoration: InputDecoration(labelText: "Năm sinh: "),
                ),
                TextField(
                  controller: txtAddQueQuan,
                  decoration: InputDecoration(labelText: "Quê quán: "),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Hủy")),
            ElevatedButton(
                onPressed: () async {
                  await userSnapshot.update(
                      ten: txtAddName.text,
                      que_quan: txtAddQueQuan.text,
                      nam_sinh: int.parse(txtAddNamSinh.text)
                  );

                  Navigator.pop(context);
                }, child: Text(buttonLabel)),
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
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc muốn xóa ${data.user.ten} không ?"),
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
  }
}*/
//bai cua Long
class Userpage extends StatefulWidget {

  @override
  _UserpageState createState() => _UserpageState();
}

class _UserpageState extends State<Userpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Firebase App"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed:() =>  _showDialog(context),
      ),
      body: Center(
          child: _allUser(context)
      ),
    );
  }

  Widget _allUser(BuildContext context){
    return StreamBuilder<List<UserSnapshot>>(
      stream: getAllUserFromFirebase(),
      builder: (context, snapshot) {
        if(!snapshot.hasData)
          return Center(child: CircularProgressIndicator(),);
        else{
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(thickness: 2,),
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
                    onTap: () => _showDialog(context,userSnapshot: snapshot.data[index]),
                    closeOnTap: true,
                  ),
                  IconSlideAction(
                    caption: 'Xóa',
                    color: Colors.red,
                    icon: Icons.delete_forever,
                    onTap: () => _showDialogDelete(snapshot.data[index],context),
                    closeOnTap: true,
                  ),
                ],
                child: ListTile(
                  leading: Icon(Icons.face_sharp),
                  title:Text(snapshot.data[index].user.ten, style: TextStyle(fontSize: 20),),
                  subtitle: Text(snapshot.data[index].user.que_quan),
                  trailing: Text('${snapshot.data[index].user.nam_sinh}',style: TextStyle(fontSize: 20),),
                ),
              );
            },
          );
        }
      },
    );

  }
  Widget _streamWidget(BuildContext context){
    return StreamBuilder<UserSnapshot>(
      stream: UserSnapshot.getDocFromFirebase("1"),
      builder: (context, userSnapshot) {
        if(!userSnapshot.hasData)
          return Text("No data");
        else
        {
          return
            Text("${userSnapshot.data.user.ten}",style: TextStyle(fontSize: 20),);
        }
      },
    );
  }
  Widget _futureWidget(BuildContext context){
    return FutureBuilder<UserSnapshot>(
      future: UserSnapshot().getUserFromFirebaseByID("1"),
      builder: (context, userSnapshot){
        if(userSnapshot.hasData)
          return
            Text("${userSnapshot.data.user.ten}",style: TextStyle(fontSize: 20),);
        else
          return
            Text("Không có dữ liệu");
      },
    );
  }

  void _showDialogDelete(UserSnapshot data, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Xác nhận"),
          content: Text("Bạn có chắc muốn xóa user ${data.user.ten} không?"),
          actions: [
            ElevatedButton(
              child: Icon(Icons.cancel),
              onPressed:() =>  Navigator.pop(context),),
            ElevatedButton(
              child: Icon(Icons.check, color: Colors.red,),
              onPressed: () async{
                await data.delete();
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  TextEditingController txtAddTen = TextEditingController();
  TextEditingController txtAddQueQuan = TextEditingController();
  TextEditingController txtAddNamSinh = TextEditingController();

  _showDialogAdd(BuildContext context) {
    txtAddTen.clear();
    txtAddQueQuan.clear();
    txtAddNamSinh.clear();
    showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("Thêm user"),
            content: Column(
              children: [
                TextField(
                  controller: txtAddTen,
                  decoration: InputDecoration(labelText: "Tên:"),
                ),
                TextField(
                  controller: txtAddNamSinh,
                  decoration: InputDecoration(labelText: "Năm sinh:"),
                ),
                TextField(
                  controller: txtAddQueQuan,
                  decoration: InputDecoration(labelText: "Quê quán:"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("Hủy"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text("Thêm"),
                onPressed: () async{
                  //tham chíu đến coletion
                  User user = User(
                    ten: txtAddTen.text,
                    que_quan: txtAddQueQuan.text,
                    nam_sinh: int.parse(txtAddNamSinh.text),
                  );
                  await addUserToFirebase(user);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  _showDialogEdit(BuildContext context, UserSnapshot userSnapshot) {
    showDialog(
      context: context,
      builder: (context) {
        txtAddTen.text = userSnapshot.user.ten;
        txtAddQueQuan.text = userSnapshot.user.que_quan;
        txtAddNamSinh.text = userSnapshot.user.nam_sinh.toString();
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text("Cập nhật"),
            content: Column(
              children: [
                TextField(
                  controller: txtAddTen,
                  decoration: InputDecoration(labelText: "Tên: "),
                ),
                TextField(
                  controller: txtAddNamSinh,
                  decoration: InputDecoration(labelText: "Năm sinh: "),
                ),
                TextField(
                  controller: txtAddQueQuan,
                  decoration: InputDecoration(labelText: "Quê quán: "),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text("Hủy")),
              ElevatedButton(
                  onPressed: () async {
                    await userSnapshot.update(
                        ten: txtAddTen.text,
                        que_quan: txtAddQueQuan.text,
                        nam_sinh: int.parse(txtAddNamSinh.text)
                    );

                    Navigator.pop(context);
                  }, child: Text("Cập nhật")),
            ],
          ),
        );
      },
    );
  }

  _showDialog(BuildContext context, {UserSnapshot userSnapshot}) {
    String title = "Thêm user";
    String buttonlabel = "Thêm";
    txtAddTen.clear();
    txtAddQueQuan.clear();
    txtAddNamSinh.clear();
    showDialog(
      context: context,
      builder: (context) {
        if(userSnapshot!=null)
        {
          txtAddTen.text = userSnapshot.user.ten;
          txtAddQueQuan.text = userSnapshot.user.que_quan;
          txtAddNamSinh.text = userSnapshot.user.nam_sinh.toString();
          title="Cập nhật";
          buttonlabel="Cập nhật";
        }
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text(title),
            content: Column(
              children: [
                TextField(
                  controller: txtAddTen,
                  decoration: InputDecoration(labelText: "Tên:"),
                ),
                TextField(
                  controller: txtAddNamSinh,
                  decoration: InputDecoration(labelText: "Năm sinh:"),
                ),
                TextField(
                  controller: txtAddQueQuan,
                  decoration: InputDecoration(labelText: "Quê quán:"),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("Hủy"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: Text(buttonlabel),
                onPressed: () async{
                  //tham chíu đến coletion
                  if(userSnapshot==null){
                    User user = User(
                      ten: txtAddTen.text,
                      que_quan: txtAddQueQuan.text,
                      nam_sinh: int.parse(txtAddNamSinh.text),
                    );
                    await addUserToFirebase(user);
                  }
                  else{
                    await userSnapshot.update(
                        ten: txtAddTen.text,
                        que_quan: txtAddQueQuan.text,
                        nam_sinh: int.parse(txtAddNamSinh.text)
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
