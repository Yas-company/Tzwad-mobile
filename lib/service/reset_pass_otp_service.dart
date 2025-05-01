import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'dart:convert';

import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class ResetPassOTPService with ChangeNotifier {
  late GetOtpModel getOtpModel;
  bool isLoading = false;
  bool changePassLoading = false;

  toggleLoadingSpinner({bool? value}) {
    isLoading = value ?? !isLoading;
    print(isLoading.toString() + '------------------------');
    notifyListeners();
  }

  togglePassLoadingSpinner({bool? value}) {
    changePassLoading = value ?? !changePassLoading;
    print(changePassLoading.toString() + '------------------------');
    notifyListeners();
  }

  Future<dynamic> getOtp(email) async {
    print('$email');
    final url = Uri.parse('$baseApiUrl/send-otp-in-mail');

    try {
      final response = await http.post(url, body: {
        'email': email!.toLowerCase().trim(),
      });
      if (response.statusCode == 200) {
        final data = GetOtpModel.fromJson(jsonDecode(response.body));
        print(data.email.toString() + '_____' + data.otp);
        getOtpModel = data;

        notifyListeners();
        return true;
      }
      final data = json.decode(response.body);
      if (data.contaisKey('message')) {
        return data['message'];
      }
      return asProvider.getString('Request failed');
    } catch (error) {
      print(error);

      rethrow;
    }
  }

  Future<dynamic> resetPassword(email, password) async {
    print('$email $password');
    final url = Uri.parse('$baseApiUrl/reset-password');

    try {
      final response = await http.post(url, body: {
        'password': password,
        'email': email!.toLowerCase().trim(),
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data['message']);

        notifyListeners();
        return;
      }
      if (response.statusCode == 422) {
        final data = json.decode(response.body);
        return data['message'];
      }

      return asProvider.getString('Something went wrong');
    } catch (error) {
      print(error);

      rethrow;
    }
  }
}

GetOtpModel getOtpModelFromJson(String str) =>
    GetOtpModel.fromJson(json.decode(str));

String getOtpModelToJson(GetOtpModel data) => json.encode(data.toJson());

class GetOtpModel {
  GetOtpModel({
    required this.otp,
    required this.email,
  });

  String email;
  String otp;

  factory GetOtpModel.fromJson(Map<String, dynamic> json) => GetOtpModel(
        email: json["email"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
      };
}
