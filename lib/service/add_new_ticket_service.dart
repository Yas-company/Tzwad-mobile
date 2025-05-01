import 'package:flutter/material.dart';
import 'dart:convert';

import '../../service/common_service.dart';
import '../../view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

class AddNewTicketService with ChangeNotifier {
  String? title;
  String? subject;
  String? selectedPriority = 'Low';
  String? description;
  List<Datum> allDepartment = [];
  bool isLoading = false;
  late Datum selectedDepartment;
  List<String> departmentNames = [];
  List<String> priority = [
    'Low',
    'Normal',
    'High',
    'Urgent',
  ];
  var header = {
    //if header type is application/json then the data should be in jsonEncode method
    "Accept": "application/json",
    "Authorization": "Bearer $globalUserToken",
  };

  setTitle(value) {
    title = value;
    notifyListeners();
  }

  setSelectedPriority(value) {
    selectedPriority = value;
    notifyListeners();
  }

  setSelectedDepartment(value) {
    selectedDepartment =
        allDepartment.firstWhere((element) => element.name == value);
    notifyListeners();
  }

  setSubject(value) {
    subject = value;
    notifyListeners();
  }

  setDescription(value) {
    description = value;
    notifyListeners();
  }

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  clearAllData() {
    title = '';
    subject = '';
    allDepartment = [];
    notifyListeners();
  }

  Future<dynamic> addNewToken() async {
    print('$globalUserToken --------------');
    final url = Uri.parse('$baseApiUrl/user/ticket/create');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };

    print(
        '$title, $selectedDepartment, ${selectedDepartment.id}, $subject, $description');
    try {
      final response = await http.post(url, headers: header, body: {
        'title': title,
        'subject': subject,
        'priority': selectedPriority!.toLowerCase(),
        'description': description,
        'departments': selectedDepartment.id.toString(),
      });
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        notifyListeners();
        return;
      }
      if (response.statusCode == 422) {
        final data = json.decode(response.body);
        print(data['message']);
        return data['message'];
      }

      return asProvider.getString('Something went wrong');
    } catch (error) {
      print(error);

      rethrow;
    }
  }

  Future fetchDepartments() async {
    final url = Uri.parse('$baseApiUrl/user/get-department');
    // print(
    //     '$title, $selectedDepartment, ${selectedDepartment.id}, $subject, $description');
    try {
      final response = await http.get(url, headers: header);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = deparmentModelFromJson(response.body);
        allDepartment = data.data;
        List<String> nameData = [];
        for (var element in allDepartment) {
          nameData.add(element.name);
        }
        departmentNames = nameData;
        print(departmentNames);
        selectedDepartment = allDepartment[0];
        notifyListeners();
        return;
      }
    } catch (error) {
      print(error);
    }
  }
}

// To parse this JSON data, do
//
//     final deparmentModel = deparmentModelFromJson(jsonString);

DeparmentModel deparmentModelFromJson(String str) =>
    DeparmentModel.fromJson(json.decode(str));

String deparmentModelToJson(DeparmentModel data) => json.encode(data.toJson());

class DeparmentModel {
  DeparmentModel({
    required this.data,
  });

  List<Datum> data;

  factory DeparmentModel.fromJson(Map<String, dynamic> json) => DeparmentModel(
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
    required this.status,
  });

  dynamic id;
  String name;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
      };
}
