import 'dart:convert';

import 'package:flutter/cupertino.dart';
import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class CampaignCardListService with ChangeNotifier {
  CampaignCardListModel? model;
  List<Datum> campList = [];
  Future fetchCampaignCardList() async {
    final url = Uri.parse('$baseApiUrl/campaign');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = CampaignCardListModel.fromJson(jsonDecode(response.body));
      model = data;
      campList = model!.data;
      notifyListeners();
    }
    return;
  }
}

CampaignCardListModel campaignCardListModelFromJson(String str) =>
    CampaignCardListModel.fromJson(json.decode(str));

String campaignCardListModelToJson(CampaignCardListModel data) =>
    json.encode(data.toJson());

class CampaignCardListModel {
  CampaignCardListModel({
    required this.data,
  });

  List<Datum> data;

  factory CampaignCardListModel.fromJson(Map<String, dynamic> json) =>
      CampaignCardListModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    this.startDate,
    required this.endDate,
  });

  dynamic id;
  String title;
  String subtitle;
  String image;
  DateTime? startDate;
  DateTime endDate;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
        image: json["image"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "image": image,
        "start_date": startDate == null ? null : startDate!.toIso8601String(),
        "end_date": endDate.toIso8601String(),
      };
}
