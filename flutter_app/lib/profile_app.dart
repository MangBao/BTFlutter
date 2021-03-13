import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Name Bao'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 300, height: 200, color: Colors.purple,)),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text('Họ và tên: ', style: TextStyle(fontSize: 25, color: Colors.indigo, fontWeight: FontWeight.bold),),
                  Text('Mang Bảo', style: TextStyle(fontSize: 25, color: Colors.indigo, fontWeight: FontWeight.bold),),
                ],
              )
            ],
          ),
      ),
    );
  }
}
