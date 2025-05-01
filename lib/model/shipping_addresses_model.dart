// To parse this JSON data, do
//
//     final ticketDetailsModel = ticketDetailsModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressesModel ticketDetailsModelFromJson(String str) =>
    ShippingAddressesModel.fromJson(json.decode(str));

String ticketDetailsModelToJson(ShippingAddressesModel data) =>
    json.encode(data.toJson());

class ShippingAddressesModel {
  ShippingAddressesModel({
    required this.data,
  });

  List<Datum> data;

  factory ShippingAddressesModel.fromJson(Map<String, dynamic> json) =>
      ShippingAddressesModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    required this.countryId,
    required this.stateId,
    required this.city,
    this.zipCode,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String name;
  String email;
  String phone;
  int userId;
  int countryId;
  int stateId;
  String city;
  String? zipCode;
  String address;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        userId: json["user_id"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        city: json["city"],
        zipCode: json["zip_code"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "user_id": userId,
        "country_id": countryId,
        "state_id": stateId,
        "city": city,
        "zip_code": zipCode,
        "address": address,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
