import 'package:cloud_firestore/cloud_firestore.dart';

class ThuChi {
  String lydo, thoigian;
  int sotien;
  bool thuchi;

  ThuChi(
      {this.lydo,
      this.thoigian,
      this.sotien,
      this.thuchi}); //khởi tạo thể hiện của lớp MonHoc từ cấu trúc map
  factory ThuChi.fromJson(
      Map<String, dynamic> json) //để chuyển dl thành 1 chuỗi
  {
    return ThuChi(
        lydo: json['lydo'], thoigian: json['thoigian'], sotien: json['sotien'], thuchi: json['thuchi']);
  }

  //chuyển thành cấu trúc map
  Map<String, dynamic> toJson() {
    return {
      "lydo": this.lydo,
      "thoigian": this.thoigian,
      "sotien": this.sotien,
      "thuchi": this.thuchi
    };
  }
}

//lớp dl làm việc nối firebase vói MonHOc
class ThuChiSnapshot {
  ThuChi thuChi;
  DocumentReference docReference;

  ThuChiSnapshot({this.thuChi, this.docReference});

  ThuChiSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.thuChi =
        ThuChi.fromJson(snapshot.data()); //data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> update({String lydo, int sotien, String thoigian, bool thuchi}) async {
    return await docReference.update({
      "lydo": lydo == null ? thuChi.lydo : lydo,
      "sotien": sotien == null ? thuChi.sotien : sotien,
      "thoigian": thoigian == null ? thuChi.thoigian : thoigian,
      "thuchi": thuchi == null ? thuChi.thuchi : thuchi
    });
  }

  Future<void> delete() async {
    await docReference.delete();
  }

}

Stream<List<ThuChiSnapshot>> getAllFromFirebase() {
  Stream<QuerySnapshot> querySnap =
      FirebaseFirestore.instance.collection("ThuChi").snapshots();
  Stream<List<DocumentSnapshot>> list =
      querySnap.map((qsn) => qsn.docs); //thực hiện trên mỗi Document
  Stream<List<ThuChiSnapshot>> listUserSn = list.map((listDocSn) => listDocSn
      .map((docSnap) => ThuChiSnapshot.fromSnapshot(docSnap))
      .toList());
  return listUserSn;
}

Future<void> addThuChiToFirebase(ThuChi monHoc) async {
  var collectionRef = FirebaseFirestore.instance.collection("ThuChi");
  await collectionRef.add(monHoc.toJson());
  return;
}
