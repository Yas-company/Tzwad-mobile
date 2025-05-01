import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'dart:convert';

import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class ChangePasswordService with ChangeNotifier {
  String currentPass = '';
  String newPass = '';
  bool isLoading = false;
  bool changePassLoading = false;

  setCurrentPass(value) {
    currentPass = value;
    notifyListeners();
  }

  setNewPass(value) {
    newPass = value;
    notifyListeners();
  }

  toggleLaodingSpinner({bool? value}) {
    isLoading = value ?? !isLoading;
    print(isLoading.toString() + '------------------------');
    notifyListeners();
  }

  toggPassleLaodingSpinner({bool? value}) {
    changePassLoading = value ?? !changePassLoading;
    print(changePassLoading.toString() + '------------------------');
    notifyListeners();
  }

  Future<dynamic> changePassword(cPass, nPass, token) async {
    print('$cPass $nPass');
    print('$token --------------');
    final url = Uri.parse('$baseApiUrl/user/change-password');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    try {
      final response = await http.post(url,
          headers: header,
          body: jsonEncode({
            'current_password': cPass,
            'new_password': nPass,
          }));
      print(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data['message']);

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
}
