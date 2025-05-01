import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class TermsAndCondition with ChangeNotifier {
  bool rtl = false;
  String html = '';

  Future getTermsAndCondi(uri) async {
    final url = Uri.parse(uri);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        html = jsonDecode(response.body)["content"];
        if (html.isEmpty) {
          return '';
        }
        notifyListeners();
        return;
      }
      throw '';
    } catch (error) {
      // print(error);

      rethrow;
    }
  }
}
