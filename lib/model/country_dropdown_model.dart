// To parse this JSON data, do
//
//     final countryDropdownModel = countryDropdownModelFromJson(jsonString);

import 'dart:convert';

CountryDropdownModel countryDropdownModelFromJson(String str) =>
    CountryDropdownModel.fromJson(json.decode(str));

String countryDropdownModelToJson(CountryDropdownModel data) =>
    json.encode(data.toJson());

class CountryDropdownModel {
  final Countries? countries;

  CountryDropdownModel({
    this.countries,
  });

  factory CountryDropdownModel.fromJson(Map<String, dynamic> json) =>
      CountryDropdownModel(
        countries: json["countries"] == null
            ? null
            : Countries.fromJson(json["countries"]),
      );

  Map<String, dynamic> toJson() => {
        "countries": countries?.toJson(),
      };
}

class Countries {
  final List<Datum>? data;
  final String? nextPageUrl;

  Countries({
    this.data,
    this.nextPageUrl,
  });

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Datum {
  final int? id;
  final String? name;

  Datum({
    this.id,
    this.name,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
