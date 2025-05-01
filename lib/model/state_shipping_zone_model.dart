// To parse this JSON data, do
//
//     final stateShippingZoneModel = stateShippingZoneModelFromJson(jsonString);

import 'dart:convert';

import 'country_shipping_zone_model.dart';

StateShippingZoneModel stateShippingZoneModelFromJson(String str) =>
    StateShippingZoneModel.fromJson(json.decode(str));

String stateShippingZoneModelToJson(StateShippingZoneModel data) =>
    json.encode(data.toJson());

class StateShippingZoneModel {
  StateShippingZoneModel({
    required this.tax,
    this.taxPercentage,
    required this.shippingOptions,
    required this.defaultShipping,
    required this.defaultShippingCost,
  });

  num tax;
  num? taxPercentage;
  List<DefaultShipping> shippingOptions;
  DefaultShipping defaultShipping;
  num defaultShippingCost;

  factory StateShippingZoneModel.fromJson(Map<String, dynamic> json) =>
      StateShippingZoneModel(
        tax: json["tax"] is String
            ? num.tryParse(json["tax"])
            : json["tax"] ?? 0.0,
        taxPercentage: json["tax_percentage"],
        shippingOptions: List<DefaultShipping>.from(
            json["shipping_options"].map((x) => DefaultShipping.fromJson(x))),
        defaultShipping: DefaultShipping.fromJson(json["default_shipping"]),
        defaultShippingCost: json["default_shipping_cost"] is String
            ? num.tryParse(json["default_shipping_cost"]) ?? 0.0
            : json["default_shipping_cost"] ?? 0.0,
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
        "tax_percentage": taxPercentage,
        "shipping_options":
            List<dynamic>.from(shippingOptions.map((x) => x.toJson())),
        "default_shipping": defaultShipping.toJson(),
        "default_shipping_cost": defaultShippingCost,
      };
}

// class DefaultShipping {
//   DefaultShipping({
//     required this.id,
//     required this.name,
//     required this.zoneId,
//     required this.isDefault,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.options,
//     required this.availableOptions,
//   });

//   dynamic id;
//   String name;
//   int zoneId;
//   int isDefault;
//   DateTime createdAt;
//   DateTime updatedAt;
//   Options options;
//   Options availableOptions;

//   factory DefaultShipping.fromJson(Map<String, dynamic> json) =>
//       DefaultShipping(
//         id: json["id"],
//         name: json["name"],
//         zoneId: json["zone_id"],
//         isDefault: json["is_default"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//         options: Options.fromJson(json["options"]),
//         availableOptions: Options.fromJson(json["available_options"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "zone_id": zoneId,
//         "is_default": isDefault,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//         "options": options.toJson(),
//         "available_options": availableOptions.toJson(),
//       };
// }

class Options {
  Options({
    required this.id,
    required this.title,
    required this.shippingMethodId,
    required this.status,
    required this.taxStatus,
    required this.settingPreset,
    required this.cost,
    required this.minimumOrderAmount,
    this.coupon,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  String title;
  int shippingMethodId;
  int status;
  int taxStatus;
  String settingPreset;
  int cost;
  int minimumOrderAmount;
  String? coupon;
  DateTime createdAt;
  DateTime updatedAt;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        id: json["id"],
        title: json["title"],
        shippingMethodId: json["shipping_method_id"],
        status: json["status"],
        taxStatus: json["tax_status"],
        settingPreset: json["setting_preset"],
        cost: json["cost"],
        minimumOrderAmount: json["minimum_order_amount"],
        coupon: json["coupon"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "shipping_method_id": shippingMethodId,
        "status": status,
        "tax_status": taxStatus,
        "setting_preset": settingPreset,
        "cost": cost,
        "minimum_order_amount": minimumOrderAmount,
        "coupon": coupon,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
