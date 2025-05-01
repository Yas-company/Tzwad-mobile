// To parse this JSON data, do
//
//     final stateDropdownModel = stateDropdownModelFromJson(jsonString);

import 'dart:convert';

StateDropdownModel stateDropdownModelFromJson(String str) =>
    StateDropdownModel.fromJson(json.decode(str));

String stateDropdownModelToJson(StateDropdownModel data) =>
    json.encode(data.toJson());

class StateDropdownModel {
  final State? state;

  StateDropdownModel({
    this.state,
  });

  factory StateDropdownModel.fromJson(Map<String, dynamic> json) =>
      StateDropdownModel(
        state: json["state"] == null ? null : State.fromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "state": state?.toJson(),
      };
}

class State {
  final int? currentPage;
  final List<Datum>? data;
  final dynamic nextPageUrl;

  State({
    this.currentPage,
    this.data,
    this.nextPageUrl,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        currentPage: json["current_page"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Datum {
  final int? id;
  final String? name;
  final int? countryId;

  Datum({
    this.id,
    this.name,
    this.countryId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
      };
}
