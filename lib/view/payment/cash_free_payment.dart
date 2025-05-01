import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../service/payment_gateaway_service.dart';
import '../cart/payment_status.dart';
import '../utils/constant_styles.dart';

class CashFreePayment {
  late BuildContext context;

  Future doPayment(BuildContext context) async {
    this.context = context;
    final checkoutData =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    if (selectedGateaway.appId == null || selectedGateaway.secretKey == null) {
      snackBar(context, asProvider.getString('Invalid developer keys'));
      return;
    }

    final url = Uri.parse("https://test.cashfree.com/api/v2/cftoken/order");
    final checkoutInfo = Provider.of<CheckoutService>(context, listen: false);
    final orderId = checkoutInfo.checkoutModel!.id;

    final response = await http.post(url,
        headers: {
          // "x-client-id": "223117f0ebd2772a15e84c769e711322",
          // "x-client-secret": "TESTd1389be7307c3b4afcd2a933cb69a0f3ec57ac30",
          "x-client-id": selectedGateaway.appId as String,
          "x-client-secret": selectedGateaway.secretKey as String,
        },
        body: jsonEncode({
          "orderId": "${orderId}",
          "orderAmount": checkoutData!.totalAmount.toString(),
          "orderCurrency": "INR"
        }));
    print(jsonDecode(response.body)['cftoken']);
    print(response.statusCode);
    if (200 == 200) {
      Map<String, dynamic> inputParams = {
        "orderId": "${orderId}",
        "orderAmount": checkoutData.totalAmount.toString(),
        "customerName": checkoutData.name,
        "orderCurrency": "INR",
        "appId": selectedGateaway.appId as String,
        "customerPhone": checkoutData.phone,
        "customerEmail": checkoutData.email,
        "stage": "TEST",
        // "color1": "#00B106",
        // "color2": "#ffffff",
        "tokenData": jsonDecode(response.body)['cftoken'],
        // "tokenData":
        //     "c39JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.D49JyMmdzNxQmZmRzYwMjNiojI0xWYz9lIsMTOyMDNzQjN2EjOiAHelJCLiQ0UVJiOik3YuVmcyV3QyVGZy9mIsISNyUjI6ICduV3btFkclRmcvJCLiEDN2YjNiojIklkclRmcvJye.CW3ctYcUTPPE_oIuBaOZZ0hyxQ0_6FrEJdCTDKaqHQeEfHLCYimeq5GTIH6TBluSB2",
      };
      print(inputParams);
      final result = await CashfreePGSDK.doPayment(inputParams).then((value) {
        print('cashfree payment result $value');
        if (value != null) {
          if (value['txStatus'] == "SUCCESS") {
            print('Cashfree Payment successfull. Do something here');
            Provider.of<ConfirmPaymentService>(context, listen: false)
                .confirmPayment(context);
          }
          if (value['txStatus'] == "CANCELLED") {
            print('Cashfree Payment successfull. Do something here');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => PaymentStatusView(true)),
                (Route<dynamic> route) => false);
          }
          if (value['txStatus'] == "FAILED") {
            print('Cashfree Payment successfull. Do something here');
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => PaymentStatusView(true)),
                (Route<dynamic> route) => false);
          }
        }
      });
      print(result!['txMsg']);
    }
  }
}
