import 'package:cloud_firestore/cloud_firestore.dart';
/*
class User {
  String ten, que_quan;
  int nam_sinh;

  // ignore: non_constant_identifier_names
  User({this.ten, this.que_quan, this.nam_sinh});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        ten: json["ten"],
        nam_sinh: json["nam_sinh"],
        que_quan: json["que_quan"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "ten": this.ten,
      "nam_sinh": this.nam_sinh,
      "que_quan": this.que_quan
    };
  }
}
class UserSnapshot{
  User user;
  DocumentReference documentReference;

  UserSnapshot({this.user, this.documentReference});
  UserSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    this.user = User.fromJson(snapshot.data());
    this.documentReference = snapshot.reference;
  }
// Trc khi sửa là ntn
  Future<void> update({String ten, String que_quan, int nam_sinh}) async {
    await documentReference.update({
      "ten": ten == null ? user.ten : ten,
      "nam_sinh": nam_sinh == null ? user.nam_sinh : nam_sinh,
      "que_quan": que_quan == null ? user.que_quan : que_quan,
    });
  }
// Sau khi sửa sẽ là ntn
  */
/*Future<void> update(User user) async {
    await documentReference.update(user.toJson());
  }*//*


  Future<void> delete() async{
    await documentReference.delete();
  }

  Future<UserSnapshot> getUserFromFireBaseByID(String id) async{
    var snapshot = await FirebaseFirestore.instance.collection("User").doc(id).get();
    return UserSnapshot.fromSnapshot(snapshot);
  }
  */
/*static Stream<DocumentSnapshot> getDocFromFireeBase(String id){
    var docSnapshot = FirebaseFirestore.instance.collection("User").doc(id).snapshots();
    return docSnapshot;
  }*//*

  static Stream<UserSnapshot> getDocFromFireBase(String id){
    var docSnapshot = FirebaseFirestore.instance.collection("User").doc(id).snapshots();
    return docSnapshot.map((docSnapshot) => UserSnapshot.fromSnapshot(docSnapshot));
  }

}
Stream<List<UserSnapshot>> getAll()
{
  Stream<QuerySnapshot> querySnap = FirebaseFirestore.instance.collection("User").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnap.map((qsn) => qsn.docs);
  Stream<List<UserSnapshot>> listUserSn = list.map((listDocSn) =>
      listDocSn.map((docSnap) => UserSnapshot.fromSnapshot(docSnap)).toList());
  return listUserSn;
}
Future<void> addUserToFirebase(User user) async {
  var collectionRef = FirebaseFirestore.instance.collection("User");
  await collectionRef.add(user.toJson());
  return;
}*/
// bai cua Long
class User {
  String ten, que_quan;
  int nam_sinh;

  User({this.ten, this.que_quan, this.nam_sinh});

  //khởi tạo thể hiện của lớp user từ cấu trúc map
  factory User.fromJson(Map<String, dynamic> json){//để chuyển dl thành 1 chuỗi
    return User(
        nam_sinh: json["nam_sinh"],
        que_quan: json["que_quan"],
        ten: json["ten"]
    );
  }
  //chuyển thành cấu trúc map
  Map<String, dynamic> toJson(){
    return {
      "ten" : this.ten,
      "que_quan" : this.que_quan,
      "nam_sinh" : this.nam_sinh,
    };
  }
}
//lớp dl làm việc nối firebase vói user
class UserSnapshot {
  User user;
  DocumentReference docReference;

  UserSnapshot({this.user, this.docReference});

  UserSnapshot.fromSnapshot(DocumentSnapshot snapshot){
    //collection tương đương 1 bảng
    //document tương đương 1 hàng
    //docreference tham chiếu đến vị trí của một document trong cơ sở dữ liệu firebasefirestore,
    // và có thể dùng để đọc, ghi, nghe, đến vị trí đó

    this.user = User.fromJson(snapshot.data());//data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> update({String ten, String que_quan, int nam_sinh}) async{
    await docReference.update({
      "nam_sinh" : nam_sinh == null ? user.nam_sinh : nam_sinh,
      "ten" : ten == null ? user.ten : ten,
      "que_quan" : que_quan == null ? user.que_quan : que_quan,
    });
  }

  Future<void> delete() async{
    await docReference.delete();
  }

  Future<UserSnapshot> getUserFromFirebaseByID(String id) async {
    var snapshot = await FirebaseFirestore.instance.collection("User").doc(id).get();//tr về future
    return UserSnapshot.fromSnapshot(snapshot);
  }

  static Stream<UserSnapshot> getDocFromFirebase(String id){
    var docSnapshot = FirebaseFirestore.instance.collection("User").doc(id).snapshots();
    return docSnapshot.map((docSnapshot) => UserSnapshot.fromSnapshot(docSnapshot));// event là docSnp
  }
//tu docSn chuyen ve snap
}

Stream<List<UserSnapshot>> getAllUserFromFirebase()
{
  Stream<QuerySnapshot> querySnap = FirebaseFirestore.instance.collection("User").snapshots();
  Stream<List<DocumentSnapshot>> list = querySnap.map((qsn) => qsn.docs);//thực hiện trên mỗi Document

  Stream<List<UserSnapshot>> listUserSn = list.map((listDocSn)
  => listDocSn.map((docSnap) => UserSnapshot.fromSnapshot(docSnap)).toList());
  return listUserSn;
}

//khi nao su dung toList ruot ben trong la j, neu ben trong la list thi sao pt map thi goi toList
//goi toList de duyet all thanh phan cua list do

Future<void> addUserToFirebase(User user) async{
  var collectionRef = FirebaseFirestore.instance.collection("User");
  await collectionRef.add(user.toJson());
  return;
}

Future<void> addUserToFirebase1(User user,String id) async{
  var collectionRef = FirebaseFirestore.instance.collection("User");
  await collectionRef.doc(id).set(user.toJson());
  return;
}