import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String ten, diachi, taikhoan, matkhau, sdt;

  User({this.ten, this.diachi, this.taikhoan, this.matkhau, this.sdt});

  //khởi tạo thể hiện của lớp user từ cấu trúc map
  factory User.fromJson(Map<String, dynamic> json) {
    //để chuyển dl thành 1 chuỗi
    return User(
        diachi: json["diachi"],
        matkhau: json["matkhau"],
        sdt: json["sdt"],
        taikhoan: json["taikhoan"],
        ten: json["ten"]);
  }

  //chuyển thành cấu trúc map
  Map<String, dynamic> toJson() {
    return {
      "ten": this.ten,
      "diachi": this.diachi,
      "matkhau": this.matkhau,
      "sdt": this.sdt,
      "taikhoan": this.taikhoan,
    };
  }
}

class UserSnapshot {
  User user;
  DocumentReference docReference;

  UserSnapshot({this.user, this.docReference});

  UserSnapshot.fromSnapshot(DocumentSnapshot snapshot) {
    //collection tương đương 1 bảng
    //document tương đương 1 hàng
    //docreference tham chiếu đến vị trí của một document trong cơ sở dữ liệu firebasefirestore,
    // và có thể dùng để đọc, ghi, nghe, đến vị trí đó

    this.user =
        User.fromJson(snapshot.data()); //data để trích xuất dl, trả về đt map
    this.docReference = snapshot.reference;
  }

  Future<void> delete() async {
    await docReference.delete();
  }

  Future<UserSnapshot> getUserFromFirebaseByID(String id) async {
    var snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(id)
        .get(); //tr về future
    return UserSnapshot.fromSnapshot(snapshot);
  }
}
