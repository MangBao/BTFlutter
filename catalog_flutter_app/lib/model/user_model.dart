class Users {
  String id;
  String userName;
  String passWord;

  Users({this.id, this.userName, this.passWord});

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
        userName: json['userName'] as String,
        passWord: json['passWord'] as String);
  }

  Map<String, dynamic> toJson() =>
      {'userName': userName, 'passWord': passWord};
// Users.fromJson(Map<String, dynamic> json){
//   userName = json['userName'];
//   passWord = json['passWord'];
//
// }

}
