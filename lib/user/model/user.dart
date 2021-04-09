import 'package:flutter/cupertino.dart';

class User {
  int id;
  String fullName, email, password;

  User({
    this.id,
    @required this.fullName,
    @required this.email,
    @required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        fullName: json["fullname"],
        password: json["password"],
        email: json["email"]);
  }

  @override
  String toString() {
    return "User: {id: $id, fullname: $fullName, email: $email}";
  }
}
