class User {
  String? id;
  String? userName;
  String? password;

  User({this.id, this.userName, this.password});

  User.fromJson(Map<dynamic, dynamic> json) {
    id = json['_id'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userName' : userName,
      'password' : password,
    };
  }
}