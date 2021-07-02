import 'package:cloud_firestore/cloud_firestore.dart';

class NhatKys {
  String date;
  String mood;
  String note;
  String weekday;
  String day;

  NhatKys(
      {this.date,
        this.mood,
        this.note,
        this.weekday,
        this.day}); //khởi tạo thể hiện của lớp MonHoc từ cấu trúc map
  factory NhatKys.fromJson(
      Map<String, dynamic> json) //để chuyển dl thành 1 chuỗi
  {
    return NhatKys(
        date: json["date"],
        mood: json["mood"],
        note: json["note"],
        weekday: json["weekday"],
        day: json["day"]);
  }

  //chuyển thành cấu trúc map
  Map<String, dynamic> toJson() {
    return {
      "date": this.date,
      "mood": this.mood,
      "note": this.note,
      "weekday": this.weekday,
      "day": this.day
    };
  }
}

//lớp dl làm việc nối firebase vói Nhatky
class NhatKySnapshot {
  NhatKys nhatKy;
  DocumentReference docReference;

  NhatKySnapshot({this.nhatKy, this.docReference});

  NhatKySnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    this.nhatKy =
        NhatKys.fromJson(snapshot.data()); //data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> update(
      {String date,
        String mood,
        String note,
        String weekday,
        String day}) async {
    return await docReference.update({
      "mood": mood == null ? nhatKy.mood : mood,
      "note": note == null ? nhatKy.note : note,
      "date": date == null ? nhatKy.date : date,
      "day": day == null ? nhatKy.day : day,
      "weekday": weekday == null ? nhatKy.weekday : weekday,
    });
  }

  Future<void> delete() async {
    await docReference.delete();
  }
}

Stream<List<NhatKySnapshot>> getAllFromFirebase() {
  Stream<QuerySnapshot> querySnap =
  FirebaseFirestore.instance.collection("NhatKys").snapshots();
  Stream<List<DocumentSnapshot>> list =
  querySnap.map((qsn) => qsn.docs); //thực hiện trên mỗi Document
  Stream<List<NhatKySnapshot>> listUserSn = list.map((listDocSn) => listDocSn
      .map((docSnap) => NhatKySnapshot.fromSnapshot(docSnap))
      .toList());
  return listUserSn;
}

Future<void> addNhatKyToFirebase(NhatKys nhatKy) async {
  var collectionRef = FirebaseFirestore.instance.collection("NhatKys");
  await collectionRef.add(nhatKy.toJson());
  return;
}
