import 'package:flutter/material.dart';
import 'package:gren_mart/service/checkout_service.dart';
import 'package:gren_mart/view/cart/payment_status.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import '../../service/common_service.dart';
import 'package:http/http.dart' as http;

class ConfirmPaymentService with ChangeNotifier {
  bool isLoading = false;

  toggleLaodingSpinner(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<dynamic> confirmPayment(BuildContext context) async {
    await Future.delayed(Duration(milliseconds: 500));

    final url = Uri.parse('$baseApiUrl/user/checkout/payment/update');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      'Content-Type': 'application/json',
      "Authorization": "Bearer $globalUserToken",
    };
    // try {
    final response = await http.post(url,
        headers: header,
        body: jsonEncode({
          'order_id': Provider.of<CheckoutService>(context, listen: false)
              .checkoutModel!
              .id
              .toString(),
          'payment_status': '1',
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => PaymentStatusView(false,
                  trackId: Provider.of<CheckoutService>(context, listen: false)
                      .checkoutModel!
                      .id)),
          (Route<dynamic> route) => false);
      notifyListeners();
      return;
    }
    if (response.statusCode == 422) {
      final data = json.decode(response.body);
      print(response.body);
      snackBar(context, asProvider.getString('Connection failed'),
          backgroundColor: cc.orange);
      return data['message'];
    }

    return asProvider.getString('Something went wrong');
    // } catch (error) {
    //   print(error);
    // }
  }

  Future reportPaymentFailed(id) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Authorization": "Bearer $globalUserToken",
    };
    final url = Uri.parse('$baseApiUrl/user/checkout/payment/failed');
    final response = await http
        .post(url, headers: header, body: {"order_id": id.toString()});

    if (response.statusCode == 200) {
      print('Payment failed report successfull');
    } else {}
    print(response.body);
  }
}
