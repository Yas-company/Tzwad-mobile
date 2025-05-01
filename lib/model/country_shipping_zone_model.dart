// To parse this JSON data, do
//
//     final countryShippingZoneModel = countryShippingZoneModelFromJson(jsonString);

import 'dart:convert';

CountryShippingZoneModel countryShippingZoneModelFromJson(String str) =>
    CountryShippingZoneModel.fromJson(json.decode(str));

String countryShippingZoneModelToJson(CountryShippingZoneModel data) =>
    json.encode(data.toJson());

class CountryShippingZoneModel {
  CountryShippingZoneModel({
    required this.tax,
    this.taxPercentage,
    required this.states,
    required this.shippingOptions,
    required this.defaultShipping,
    required this.defaultShippingCost,
  });

  num tax;
  int? taxPercentage;
  List<State> states;
  List<DefaultShipping> shippingOptions;
  DefaultShipping defaultShipping;
  num defaultShippingCost;

  factory CountryShippingZoneModel.fromJson(Map<String, dynamic> json) =>
      CountryShippingZoneModel(
        tax: json["tax"] is String ? num.parse(json["tax"]) : json["tax"],
        taxPercentage: json["tax_percentage"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
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
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
        "shipping_options":
            List<dynamic>.from(shippingOptions.map((x) => x.toJson())),
        "default_shipping": defaultShipping.toJson(),
        "default_shipping_cost": defaultShippingCost,
      };
}

class DefaultShipping {
  DefaultShipping({
    required this.id,
    required this.name,
    required this.zoneId,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.options,
    required this.availableOptions,
  });

  dynamic id;
  String name;
  dynamic zoneId;
  dynamic isDefault;
  DateTime createdAt;
  DateTime updatedAt;
  Options options;
  Options availableOptions;

  factory DefaultShipping.fromJson(Map<String, dynamic> json) =>
      DefaultShipping(
        id: json["id"],
        name: json["name"],
        zoneId: json["zone_id"],
        isDefault: json["is_default"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        options: Options.fromJson(json["options"]),
        availableOptions: Options.fromJson(json["available_options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "zone_id": zoneId,
        "is_default": isDefault,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "options": options.toJson(),
        "available_options": availableOptions.toJson(),
      };
}

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
  });

  dynamic id;
  String title;
  dynamic shippingMethodId;
  dynamic status;
  dynamic taxStatus;
  String settingPreset;
  num cost;
  num minimumOrderAmount;
  String? coupon;

  factory Options.fromJson(Map<String, dynamic> json) => Options(
        id: json["id"],
        title: json["title"],
        shippingMethodId: json["shipping_method_id"],
        status: json["status"],
        taxStatus: json["tax_status"],
        settingPreset: json["setting_preset"],
        cost:
            json["cost"] is String ? num.tryParse(json["cost"]) : json["cost"],
        minimumOrderAmount: json["minimum_order_amount"] is String
            ? num.tryParse(json["minimum_order_amount"])
            : json["minimum_order_amount"],
        coupon: json["coupon"],
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
      };
}

class State {
  State({
    required this.id,
    required this.name,
  });

  dynamic id;
  String name;

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
