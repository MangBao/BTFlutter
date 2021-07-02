import 'package:bai3_nongsan/model/nongsan_model.dart';
import 'package:flutter/material.dart';

import 'chitietnongsan_page.dart';

class NongSanPage extends StatefulWidget {
  const NongSanPage({Key key}) : super(key: key);

  @override
  _NongSanPageState createState() => _NongSanPageState();
}

class _NongSanPageState extends State<NongSanPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nông sản",
      home: showAllNongSan(context),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget showAllNongSan(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Giải cứu nông sản"),
        ),
        body: StreamBuilder<List<NongSanSnapshot>>(
          stream: getNongSanFromFirebase(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            else
            {
              return GridView.builder(
                //Tạo bố cục dạng lưới với các ô có phạm vi trục chéo tối đa.
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,//kích thức tối đa 200
                      //childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,//khoản cách chìu ngang
                      mainAxisSpacing: 10//khoản cách chìu dọc
                  ),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Card(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                //data[index] là để xác định đúng vị trí của dữ liệu mình cần cập nhật ở trang cập nhật
                                MaterialPageRoute(builder: (context) => CT_NongSanPage(nongSanSnapshot: snapshot.data[index],)));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Image.network(snapshot.data[index].nongSan.anhns),
                                Text(snapshot.data[index].nongSan.tenns,style: TextStyle(fontSize: 18),),
                                Text("Giá: "+ snapshot.data[index].nongSan.gia.toString()+"/kg",style: TextStyle(color: Colors.redAccent),)
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        )
    );
  }
}
