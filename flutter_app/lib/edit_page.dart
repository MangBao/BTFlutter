import 'package:flutter/material.dart';
import 'package:flutter_app/model.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

Future<DateTime> _selectDate(DateTime initialDate, BuildContext context) async {
  DateTime date = initialDate == null ? DateTime.now() : initialDate;
  var datePicked = await showDatePicker(
    context: context,
    initialDate: date,
    firstDate: DateTime.now().subtract(Duration(days: 365*50)),
    lastDate: DateTime.now().add(Duration(days: 365*50)),
  );
  return datePicked;
}

class EditPage extends StatefulWidget {
  MyProfile profile;

  EditPage({Key key, this.profile});//contructer

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController hoTenTextEditingController = TextEditingController();
  TextEditingController ngaySinhTextEditingController = TextEditingController();
  TextEditingController queQuanTextEditingController = TextEditingController();
  TextEditingController soThichTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildTextEdit("Họ tên", hoTenTextEditingController),
            SizedBox(
              height: 15,
            ),
            Text('Giới tính'),
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
                    groupValue: widget.profile.nam,
                    onChanged: (value) => setState(
                          () => widget.profile.nam = value,
                    ),
                  ),

                  RadioButton(
                    description: "Nữ",
                    value: false,
                    groupValue: widget.profile.nam,
                    onChanged: (value) => setState(
                          () => widget.profile.nam = value,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(child: _buildTextEdit("Ngày sinh", ngaySinhTextEditingController)),
                TextButton(onPressed: () async {
                  var newDate = await _selectDate(widget.profile.ngaySinh, context);
                  if(newDate != null){
                    setState(() {
                      widget.profile.ngaySinh = newDate;
                      ngaySinhTextEditingController.text = "${newDate.day}/${newDate.month}/${newDate.year}";//$ biểu thức hổ trợ trong chuỗi
                    });
                  }
                }, child: Icon(Icons.calendar_today)),
              ],
            ),
            SizedBox(height: 15,),
            _buildTextEdit("Quê quán", queQuanTextEditingController),
            SizedBox(height: 15,),
            _buildTextEdit("Sở thích", soThichTextEditingController),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: SizedBox()),
                ElevatedButton(
                    onPressed: () => backTo(context),
                    child: Text("OK")),
                SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hoTenTextEditingController.text = widget.profile.hoTen;
    ngaySinhTextEditingController.text = widget.profile.ngaySinh.toString();
    queQuanTextEditingController.text = widget.profile.queQuan;
    soThichTextEditingController.text = widget.profile.soThich;
    // _image = widget.profile.imageAssest as File;
  }

  //những cái khác nhau chuyển về tham số
  Widget _buildTextEdit(String label, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }

  backTo(BuildContext context) {
    widget.profile.hoTen = hoTenTextEditingController.text;
    widget.profile.queQuan = queQuanTextEditingController.text;
    widget.profile.soThich = soThichTextEditingController.text;
    // widget.profile.imageAssest = _image as String;
    //chỉ gán 3 cái vì ngày sinh sexddc cập nhập
    Navigator.pop(context,widget.profile);
    // gỡ màn hình đang hiển thị ra khỏi
    //nhận đc giá trị trả về
  }


}