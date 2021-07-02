import 'package:bai3_nongsan/model/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'nongsan_page.dart';

class DangNhapPage extends StatefulWidget {
  @override
  _DangNhapPageState createState() => _DangNhapPageState();
}

class _DangNhapPageState extends State<DangNhapPage> {
  TextEditingController userName = new TextEditingController(); //để xét đc cái text(kí tự nhập vào)
  TextEditingController passWord = new TextEditingController();
  bool showPw = false;

  var txt_userErr = "Tài khoản không hợp lệ";
  var txt_pwErr = "Mật khẩu không hợp lệ";
  var userCorrect = true; //hợp lệ
  var pwCorrect = true;


  @override
  Widget build(BuildContext context) {
    // Trả về MaterialApp, Provider, ChangeNotifyProvider
      return MaterialApp(
        title: "Đăng nhập",
        home: formDangNhap(context),
        debugShowCheckedModeBanner: false,
      );
  }

  Widget formDangNhap(BuildContext context) {
    return FutureBuilder<UserSnapshot>(
        future: UserSnapshot().getUserFromFirebaseByID("9SA96wdvXPnbLnWa1b9J"),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 115, left: 20, right: 20),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 120,),
                      Center(
                        child: Text(
                          "Nông sản online 🌿",
                          style: TextStyle(fontSize: 30, color: Colors.green[400], fontWeight: FontWeight.w800),

                        ),
                      ),
                      SizedBox(height: 60,),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: userName,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Username",
                            errorText: !userCorrect ? txt_userErr : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                            //nếu như ko hơp lệ thì báo lỗi, hợp thì null(ko thông báo)
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 20),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: AlignmentDirectional.centerEnd,
                          children: [
                            TextField(
                              controller: passWord,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                              obscureText: !showPw, //chuyen thanh dau sao
                              decoration: InputDecoration(
                                labelText: "Password",
                                errorText: !pwCorrect ? txt_pwErr : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelStyle:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              ),
                            ),
                            //cử chỉ: là cách mà người dùng tương tác với các thiết bị di động
                            GestureDetector(
                                onTap: onShowPass,
                                child: IconButton(
                                  icon: Icon(Icons.remove_red_eye_rounded),
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RaisedButton(
                        child: Text('Đăng nhập',style: TextStyle(color: Colors.white),),
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            if (userName.text == snapshot.data.user.taikhoan)
                              userCorrect = true;
                            else
                              userCorrect = false;

                            if (passWord.text == snapshot.data.user.matkhau)
                              pwCorrect = true;
                            else
                              pwCorrect = false;

                            if (userCorrect && pwCorrect) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NongSanPage(),
                                  ));
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        });
  }

  void onShowPass() {
    setState(() {
      showPw = !showPw;
    });
  }


}
