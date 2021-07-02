import 'package:cloud_firestore/cloud_firestore.dart';

class NongSan {
  String tenns;
  int gia;
  String mota;
  String anhns;

  NongSan({this.tenns, this.gia, this.mota, this.anhns});

  factory NongSan.fromJson(Map<String, dynamic> json) //để chuyển dl thành 1 chuỗi
  {
    return NongSan(
      tenns: json["tenns"],
      gia: json["gia"],
      mota: json["mota"],
      anhns: json["anhns"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "tenns": this.tenns,
      "gia": this.gia,
      "mota": this.mota,
      "anhns": this.anhns
    };
  }
}

class NongSanSnapshot {
  NongSan nongSan;
  DocumentReference docReference;

  NongSanSnapshot({this.nongSan, this.docReference});

  NongSanSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.nongSan = NongSan.fromJson(snapshot.data()); //data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> update(
      {String tenns, int gia, String mota, String anhns}) async {
    return await docReference.update({
      "tenns": tenns == null ? nongSan.tenns : tenns,
      "gia": gia == null ? nongSan.gia : gia,
      "mota": mota == null ? nongSan.mota : mota,
      "anhns": anhns == null ? nongSan.anhns : anhns,
    });
  }

  Future<void> delete() async {
    return docReference.delete();
  }

  Future<void> count() async {
    final int docLenght = await FirebaseFirestore.instance.collection('GioHang').snapshots().length;
    return docLenght;
  }
}

Stream<List<NongSanSnapshot>> getNongSanFromFirebase() {
  Stream<QuerySnapshot> querySnap =
      FirebaseFirestore.instance.collection("NongSan").snapshots();
  Stream<List<DocumentSnapshot>> list =
      querySnap.map((qsn) => qsn.docs); //thực hiện trên mỗi Document
  Stream<List<NongSanSnapshot>> listUserSn = list.map((listDocSn) => listDocSn
      .map((docSnap) => NongSanSnapshot.fromSnapshot(docSnap))
      .toList());
  return listUserSn;
}

Future<void> addToFirebase(NongSan nongSan) async {
  var collectionRef = FirebaseFirestore.instance.collection("NongSan");
  await collectionRef.add(nongSan.toJson());
  return;
}
