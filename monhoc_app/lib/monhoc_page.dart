import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:monhoc_app/monhoc_model.dart';

class MonHocpage extends StatefulWidget {
  @override
  _MonHocpageState createState() => _MonHocpageState();
}

class _MonHocpageState extends State<MonHocpage> {

  String title = "";
  String buttonLabel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Môn học"),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          // onPressed: () => {
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => ThemSuaMonHoc(), //Thêm thì không cần
          //       ))
          // }
      ),
      body: Center(
          child: _allMonHoc(context)
      ),
    );
  }

  Widget _allMonHoc(BuildContext context) {
    return StreamBuilder<List<MonHocSnapshot>>(
      stream: getAllFromFirebase(),
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
                    color: Colors.lightBlue,
                    icon: Icons.update,
                    // onTap: () {
                    //   //Chuyển trang để cập nhật dữ liệu
                    //   Navigator.push(
                    //       context,
                    //       //data[index] là để xác định đúng vị trí của dữ liệu mình cần cập nhật ở trang cập nhật
                    //       MaterialPageRoute(
                    //           builder: (context) => ThemSuaMonHoc(
                    //             monHocSnapshot: snapshot.data[index],
                    //           )));
                    // },
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
                    leading: Icon(Icons.book),
                    title:Text(snapshot.data[index].monHoc.tenmh, style: TextStyle(fontSize: 20),),
                    subtitle: Text("Số tín chỉ: " + snapshot.data[index].monHoc.sotc.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_red_eye,color: Colors.lightGreen,),
                      onPressed: (){
                        _showinfo(snapshot.data[index], context);
                      },
                    )
                ),
              );
            },
          );
        }
      },
    );
  }

  _showinfo(MonHocSnapshot data, BuildContext context){
    String bb;
    if (data.monHoc.batbuoc== true)
      bb = "Có";
    else bb = "Không";
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Thông tin môn học"),
            content: Text("Mã môn học: ${data.monHoc.mamh}\n"
                "Tên môn học : ${data.monHoc.tenmh}\n"
                "Số tín chỉ: ${data.monHoc.sotc}\n"
                "Học kì : ${data.monHoc.hocki}\n"
                "Điểm trung bình : ${data.monHoc.diemtb}\n"
                "Bắt buộc: $bb"
            ),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed:() => Navigator.pop(context),
              )
            ],
          );
        }
    );
  }

  _showDialogDelete(MonHocSnapshot data, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Xác nhận"),
            content: Text("Bạn có  muốn xóa môn học ${data.monHoc.tenmh} không?"),
            actions: [
              ElevatedButton(
                child: Text("OK"),
                onPressed: () async{
                  await data.delete();
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Thoát"),
                onPressed:() => Navigator.pop(context),
              )
            ],
          );
        }
    );
  }

}
