import 'dart:convert';

import 'package:catalog_flutter_app/model/user_model.dart';
import 'package:catalog_flutter_app/pages/cataloge_page.dart';
import 'package:catalog_flutter_app/pages/staff_page.dart';
import 'package:flutter/material.dart';
import 'package:catalog_flutter_app/model/user_model.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  Map<String, dynamic> _user = jsonDecode('data/users.json');
  // Users user = Users.fromJson(_user);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              child: Column(children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Welcome', style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                  )
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                  controller: userController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 45,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () => _toLogin(context),
                    )
                )
          ])
          )
      ),
    );
  }

  void _toLogin(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("data/users.json");
    //final jsonResult = json.decode(data);
    Map<String, dynamic> _user = jsonDecode(data);
    setState(() {
      if (userController.text == {_user['userName']} as String && passwordController.text == {_user['passWord']} as String) {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatalogPage(),
            ));
      } else if (userController.text == _user[1]['userName'] as String && passwordController.text == _user[1]['passWord'] as String) {
        return Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StaffPage(),
            ));
      } else {
        return _buildShowErrorDialog(
            context, "Please check again user and password!!!");
      }
    });
  }

  Future _buildShowErrorDialog(BuildContext context, _message) {
    return showDialog(
        builder: (context) {
          return AlertDialog(
            title: Text('Error Message'),
            content: Text(_message),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'))
            ],
          );
        },
        context: context);
  }
}
