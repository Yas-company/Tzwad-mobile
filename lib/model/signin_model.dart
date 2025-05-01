// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    required this.users,
    required this.token,
  });

  Users users;
  String token;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        users: Users.fromJson(json["users"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "users": users.toJson(),
        "token": token,
      };
}

class Users {
  Users({
    required this.id,
    required this.username,
  });

  dynamic id;
  String? username;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
      };
}
