class User {
  String id;
  String userName;
  String password;

  User({
    required this.id,
    required this.userName,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userName: json["userName"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "password": password,
      };
}
