// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    required this.users,
    required this.token,
  });

  Users users;
  String token;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
    required this.name,
    required this.email,
    required this.username,
    required this.phone,
    required this.country,
    required this.state,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  String name;
  String email;
  String username;
  String phone;
  String country;
  String state;
  DateTime updatedAt;
  DateTime createdAt;
  dynamic id;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"],
        email: json["email"],
        username: json["username"],
        phone: json["phone"],
        country: json["country"],
        state: json["state"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "phone": phone,
        "country": country,
        "state": state,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
