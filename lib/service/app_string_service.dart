import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../view/utils/app_strings.dart';
import 'common_service.dart';

class AppStringService with ChangeNotifier {
  bool isloading = false;
  var tStrings;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchTranslatedStrings() async {
    if (tStrings != null) {
      //if already loaded. no need to load again
      return;
    }
    var connection = await Connectivity().checkConnectivity();
    if (connection != ConnectivityResult.none) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      setLoadingTrue();

      var data = jsonEncode({
        'strings': jsonEncode(appStrings),
      });

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(Uri.parse('$baseApiUrl/translate-string'),
          headers: header, body: data);

      if (response.statusCode == 200) {
        tStrings = jsonDecode(response.body)['strings'];
        // print(tStrings);
        notifyListeners();
      } else {
        print('error fetching translations ' + response.body);
        notifyListeners();
      }
    }
  }

  getString(String staticString) {
    // var tStrings = appStrings;
    if (tStrings == null) {
      return staticString;
    }
    if (tStrings.containsKey(staticString) &&
        tStrings[staticString].toString().isNotEmpty) {
      return tStrings[staticString];
    } else {
      return staticString;
    }
  }
}
