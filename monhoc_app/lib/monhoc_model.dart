import 'package:cloud_firestore/cloud_firestore.dart';
class MonHoc{
  String mamh;
  String tenmh;
  int sotc;
  int hocki;
  double diemtb;
  bool batbuoc;
  MonHoc({this.mamh,this.tenmh,this.sotc,this.hocki,this.diemtb,this.batbuoc});

  //khởi tạo thể hiện của lớp MonHoc từ cấu trúc map
  factory MonHoc.fromJson(Map<String, dynamic> json)//để chuyển dl thành 1 chuỗi
  {
    return MonHoc(
        mamh: json['mamh'],
        tenmh: json['tenmh'],
        sotc: json['sotc'],
        hocki: json['hocki'],
        diemtb: json['diemtb'],
        batbuoc: json['batbuoc']
    );
  }
  //chuyển thành cấu trúc map
  Map<String, dynamic> toJson()
  {
    return{
      "mamh" :this.mamh,
      "tenmh" : this.tenmh,
      "sotc" : this.sotc,
      "hocki" : this.hocki,
      "diemtb" : this.diemtb,
      "batbuoc" : this.batbuoc
    };
  }
}
//lớp dl làm việc nối firebase vói MonHOc
class MonHocSnapshot{
  MonHoc monHoc;
  DocumentReference docReference;

  MonHocSnapshot({this.monHoc, this.docReference});

  MonHocSnapshot.fromSnapshot(DocumentSnapshot snapshot){

    this.monHoc = MonHoc.fromJson(snapshot.data());//data để trích xuất dl, trả về đt map
    this.docReference=snapshot.reference;
  }
  Future<void>update({String mamh, String tenmh, int sotc, int hocki, double diemtb, bool batbuoc}) async
  {
    return await docReference.update(
        {
          "mamh" : mamh == null ? monHoc.mamh : mamh,
          "tenmh" :tenmh == null ? monHoc.tenmh : tenmh,
          "sotc" : sotc == null ? monHoc.sotc: sotc,
          "hocki" : hocki == null ? monHoc.hocki : hocki,
          "diemtb" : diemtb == null ? monHoc.diemtb : diemtb,
          "batbuoc" : batbuoc == null ? monHoc.batbuoc : batbuoc
        }
    );
  }

  Future<void> delete() async{
    await docReference.delete();
  }

  Future<MonHocSnapshot> getUserFromFirebaseByID(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("MonHocs").doc(id).get();//tr về future
    return MonHocSnapshot.fromSnapshot(snapshot);
  }

  static Stream<MonHocSnapshot> getDocFromFirebase(String id){
    var docSnapshot = FirebaseFirestore.instance.collection("MonHocs").doc(id).snapshots();
    return docSnapshot.map((docSnapshot) => MonHocSnapshot.fromSnapshot(docSnapshot));// event là docSnp
  }

}
Stream<List<MonHocSnapshot>> getAllFromFirebase()
{
  Stream<QuerySnapshot> querySnap = FirebaseFirestore.instance.collection("MonHocs").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnap.map((qsn) => qsn.docs);//thực hiện trên mỗi Document
  Stream<List<MonHocSnapshot>> listUserSn = list.map((listDocSn)
  => listDocSn.map((docSnap) => MonHocSnapshot.fromSnapshot(docSnap)).toList());
  return listUserSn;
}

Future<void> addMonHocToFirebase(MonHoc monHoc) async{
  var collectionRef = FirebaseFirestore.instance.collection("MonHocs");
  await collectionRef.add(monHoc.toJson());
  return;
}