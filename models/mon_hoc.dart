import 'package:cloud_firestore/cloud_firestore.dart';

class MonHoc {
  String maMH, tenMH, batBuoc;
  int hocky, soTC;
  double diemTB;

  MonHoc(
      {this.maMH,
      this.tenMH,
      this.hocky,
      this.soTC,
      this.diemTB,
      this.batBuoc});

  factory MonHoc.fromJson(Map<String, dynamic> json) {
    return MonHoc(
        maMH: json["maMH"],
        tenMH: json["tenMH"],
        hocky: json["hocky"],
        soTC: json["soTC"],
        diemTB: json["diemTB"],
        batBuoc: json["batBuoc"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "maMH": this.maMH,
      "tenMH": this.tenMH,
      "hocky": this.hocky,
      "soTC": this.soTC,
      "diemTB": this.diemTB,
      "batBuoc": this.batBuoc
    };
  }
}

class MonHocSnapshot {
  MonHoc mh;
  DocumentReference documentReference;

  MonHocSnapshot({this.mh, this.documentReference});

  MonHocSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.mh = MonHoc.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }

// Trc khi sửa là ntn
  Future<void> update({String maMH, String tenMH, int hocky, int soTC, double diemTB, String batBuoc}) async {
    await documentReference.update({
      "maMH": maMH == null ? mh.maMH : maMH,
      "tenMH": tenMH == null ? mh.tenMH : tenMH,
      "hocky": hocky == null ? mh.hocky : hocky,
      "soTC": soTC == null ? mh.soTC : soTC,
      "diemTB": diemTB == null ? mh.diemTB : diemTB,
      "batBuoc": batBuoc == null ? mh.batBuoc : batBuoc
    });
  }

  Future<void> delete() async {
    await documentReference.delete();
  }

  Future<MonHocSnapshot> getSubFromFireBaseByID(String id) async {
    var snapshot =
        await FirebaseFirestore.instance.collection("MonHoc").doc(id).get();
    return MonHocSnapshot.fromSnapshot(snapshot);
  }

  static Stream<MonHocSnapshot> getDocFromFireBase(String id) {
    var docSnapshot =
        FirebaseFirestore.instance.collection("MonHoc").doc(id).snapshots();
    return docSnapshot
        .map((docSnapshot) => MonHocSnapshot.fromSnapshot(docSnapshot));
  }
}

Stream<List<MonHocSnapshot>> getAll()
{
  Stream<QuerySnapshot> querySnap = FirebaseFirestore.instance.collection("MonHoc").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnap.map((qsn) => qsn.docs);
  Stream<List<MonHocSnapshot>> listMHSn = list.map((listDocSn) =>
      listDocSn.map((docSnap) => MonHocSnapshot.fromSnapshot(docSnap)).toList());
  return listMHSn;
}

Future<void> addMonHocToFirebase(MonHoc mh) async {
  var collectionRef = FirebaseFirestore.instance.collection("MonHoc");
  await collectionRef.add(mh.toJson());
  return;
}
