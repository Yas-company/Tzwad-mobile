import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/model/payment_gateaway_model.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:http/http.dart' as http;

import 'common_service.dart';

class PaymentGateawayService with ChangeNotifier {
  List<Gateway> gatawayList = [];
  Gateway? selectedGateaway;
  bool isLoading = false;

  setSelectedGareaway(value) {
    selectedGateaway = value;
    notifyListeners();
  }

  bool itemSelected(value) {
    if (selectedGateaway == null) {
      return false;
    }
    return selectedGateaway == value;
  }

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  resetGateaway() {
    gatawayList = [];
    selectedGateaway = null;
    notifyListeners();
  }

  Future fetchPaymentGetterData() async {
    final url = Uri.parse('$baseApiUrl/user/payment-gateway-list');
    print(globalUserToken);

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $globalUserToken",
      'x-api-key': 'b8f4a0ba4537ad6c3ee41ec0a43549d1'
    };

    final response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      gatawayList = PaymentGateAwayModel.fromJson(data).gatewayList;
      gatawayList.removeWhere((element) => element.name == "manual_payment");
      selectedGateaway = gatawayList.first;

      notifyListeners();
    }
  }
}
