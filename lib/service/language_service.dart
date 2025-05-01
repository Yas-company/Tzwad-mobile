import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

import '../view/utils/constant_name.dart';
import '../view/utils/constant_styles.dart';

class LanguageService with ChangeNotifier {
  bool rtl = false;
  bool currencyRTL = false;
  String currency = '\$';

  Future setLanguage(BuildContext context) async {
    final url = Uri.parse('$baseApiUrl/default-lang');
    try {
      Timer scheduleTimeout = Timer(const Duration(seconds: 10), () {
        print("server slow");
        snackBar(context, asProvider.getString("Server connection slow"),
            backgroundColor: cc.blackColor);
      });

      final response = await http.get(url);
      scheduleTimeout.cancel();

      if (response.statusCode == 200) {
        rtl = jsonDecode(response.body)['lang_info']['direction'] == 'rtl';
        notifyListeners();
      } else {
        // print('something went wrong');
      }
    } catch (error) {
      print(error);

      return;
    }
  }

  Future setCurrency() async {
    final url = Uri.parse('$baseApiUrl/site_currency_symbol');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        currency = jsonDecode(response.body)['symbol'];

        currencyRTL = jsonDecode(response.body)['direction'] != null
            ? jsonDecode(response.body)['direction'] == 'rtl'
            : false;
        notifyListeners();
      } else {
        // print('something went wrong');
      }
    } catch (error) {
      // print(error);

      //   rethrow;
    }
  }
}
