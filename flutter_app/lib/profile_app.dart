import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/edit_page.dart';
import 'package:flutter_app/model.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

class Profile_App extends StatefulWidget {
  @override
  _Profile_AppState createState() => _Profile_AppState();
}

class _Profile_AppState extends State<Profile_App> {
  MyProfile profile;
  File _image;
  final picker = ImagePicker();

  Future getImageFormCamera() async {
    final pickedImage = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if(pickedImage != null){
        _image = File(pickedImage.path);
      }else{
        print("Chưa có ảnh nào được chọn");
      }
    });
  }
  Future getImageFormFolder() async {
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if(pickedImage != null){
        _image = File(pickedImage.path);
      }else{
        print("Chưa có ảnh nào được chọn");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width*0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text("My app"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Center(
                child: Container(
                  width: size,
                  height: 2/3*size,
                  child: Image.asset(profile.imageAssest),
                ),
              ),*/
              Container(
                width: size,
                height: 2 / 3 * size,
                child: Center(
                  child: _image == null ? Image.asset(profile.imageAssest) : Image.file(_image),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: getImageFormFolder,
                    tooltip: "Chọn từ thư mục",
                    child: Icon(Icons.folder_rounded),),
                  FloatingActionButton(
                    onPressed: getImageFormCamera,
                    tooltip: "Chọn từ camera",
                    child: Icon(Icons.camera_alt_rounded),)
                ],
              ),

              SizedBox(height: 10,),
              Text("Họ và tên:"),
              Text(profile.hoTen,
                  style: TextStyle(fontSize: 20,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Giới tính"),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RadioButton(
                      description: "Nam",
                      value: true,
                      groupValue: profile.nam,
                      onChanged: (value) => setState(
                            () => profile.nam = value,
                      ),
                    ),

                    RadioButton(
                      description: "Nữ",
                      value: false,
                      groupValue: profile.nam,
                      onChanged: (value) => setState(
                            () => profile.nam = value,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text("Ngày sinh:"),
              Text(
                profile.ngaySinh == null ? "" :
                "${profile.ngaySinh.day}/${profile.ngaySinh.month}/${profile.ngaySinh.year}",
                style: TextStyle(fontSize: 18,),
            ),
              SizedBox(height: 10),
              Text("Quê quán:"),
              Text(profile.queQuan),
              SizedBox(height: 10),
              Text("Sở thích:"),
              Text(profile.soThich,
                  style: TextStyle(fontStyle: FontStyle.italic)),

              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  ElevatedButton(
                    onPressed: () => _toEditPage(context),
                      child: Text("Chỉnh sửa")),
                  SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _toEditPage(BuildContext context) async{//nhận đối số BuildContext context
    var updateProfile = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EditPage(profile: profile,),//hàm đầu vào là context, đầu ra
        )
    );
    if (updateProfile != null)
      setState(() {
        profile = updateProfile;
      });
  }

  @override
  void initState() {
    super.initState();
    profile = MyProfile(
      hoTen: "Trần Thành Công",
      ngaySinh: new DateTime(2000,1,13),
      nam: true,
      queQuan: "Nha Trang, Khánh Hòa",
      soThich: "Xem phim, nghe nhạc, cafe với bạn bè, chụp ảnh khi rãnh rỗi",
      imageAssest: "img/o.jpg"
    );
  }
}
