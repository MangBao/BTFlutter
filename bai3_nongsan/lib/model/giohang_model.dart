import 'package:cloud_firestore/cloud_firestore.dart';

class GioHang{
  String tenns, anhns;
  int gia, soluong;


  GioHang({this.tenns, this.gia,this.soluong, this.anhns});

  factory GioHang.fromJson(Map<String, dynamic> json){
    return GioHang(
        tenns: json["tenns"],
        gia: json["gia"],
        soluong: json["soluong"],
        anhns: json["anhns"]
    );
  }
  Map<String, dynamic> toJson(){
    return{
      "tenns" : this.tenns,
      "gia" : this.gia,
      "soluong" :this.soluong,
      "anhns" : this.anhns
    };
  }
}
class GioHangSnapshot{
  GioHang gioHang;
  DocumentReference docReference;

  GioHangSnapshot({this.gioHang, this.docReference});

  GioHangSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    this.gioHang = GioHang.fromJson(snapshot.data());//data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> update({String tenns, int gia,int soluong, String anhns}) async{
    return await docReference.update({
      "tenns" : tenns == null ? gioHang.tenns : tenns,
      "gia" :gia == null ? gioHang.gia : gia,
      "soluong" :soluong == null ? gioHang.soluong : soluong,
      "anhns" : anhns == null ? gioHang.anhns: anhns,
    });
  }

  Future<void> delete() async {
    return docReference.delete();
  }


}

Stream<List<GioHangSnapshot>> getGioHangFromFirebase()
{
  Stream<QuerySnapshot> querySnap = FirebaseFirestore.instance.collection("GioHang").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnap.map((qsn) => qsn.docs);//thực hiện trên mỗi Document
  Stream<List<GioHangSnapshot>> listUserSn = list.map((listDocSn)
  => listDocSn.map((docSnap) => GioHangSnapshot.fromSnapshot(docSnap)).toList());
  return listUserSn;
}

Future<void> addToGioHangFirebase(GioHang gioHang) async{
  var collectionRef = FirebaseFirestore.instance.collection("GioHang");
  await collectionRef.add(gioHang.toJson());
  return;
}
// tính tổng tiền
// Future<void> tongTienNS() async{
//   var tong = await FirebaseFirestore.instance.collection('GioHang').get();
//   tong.docs.fold(0, (previousValue, curentElement) => previousValue + curentElement.gia);
// }

//số lượng sản phẩm trong giỏ hàng
Future<void> getSL() async {
  var gio_hangsnapshot = await FirebaseFirestore.instance.collection('GioHang').get();
  gio_hangsnapshot.docs.length;
  return gio_hangsnapshot;
}
