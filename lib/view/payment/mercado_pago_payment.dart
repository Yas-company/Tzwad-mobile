import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';

import '../../service/checkout_service.dart';
import '../../service/payment_gateaway_service.dart';
import '../cart/payment_status.dart';
import '../utils/app_bars.dart';
import '../utils/constant_styles.dart';

class MercadopagoPayment extends StatelessWidget {
  MercadopagoPayment({Key? key}) : super(key: key);
  String? url;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().appBarTitled(context, '', () async {
        paymentFailedDialogue(context);
      }),
      body: WillPopScope(
        onWillPop: () async {
          paymentFailedDialogue(context);
          return false;
        },
        child: FutureBuilder(
            future: getPaymentUrl(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingProgressBar();
              }
              if (snapshot.hasData) {
                return Center(
                  child: Text(asProvider.getString('Loading failed.')),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(asProvider.getString('Loading failed.')),
                );
              }
              return WebView(
                onWebResourceError: (error) => showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(asProvider.getString('Loading failed!')),
                        content: Text(asProvider
                            .getString('Failed to load payment page.')),
                        actions: [
                          Spacer(),
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentStatusView(true)),
                                    (Route<dynamic> route) => false),
                            child: Text(
                              asProvider.getString('Return'),
                              style: TextStyle(color: cc.primaryColor),
                            ),
                          )
                        ],
                      );
                    }),
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (navData) {
                  if (navData.url.contains('success')) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PaymentStatusView(false)),
                        (Route<dynamic> route) => false);
                    return NavigationDecision.prevent;
                  }
                  if (navData.url.contains('failure') ||
                      navData.url.contains('pending')) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PaymentStatusView(true)),
                        (Route<dynamic> route) => false);
                    return NavigationDecision.prevent;
                  }
                  return NavigationDecision.navigate;
                },
              );
            }),
      ),
    );
  }

  Future<dynamic> getPaymentUrl(BuildContext context) async {
    final selectrdGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    if (selectrdGateaway.clientSecret == null) {
      snackBar(context, asProvider.getString('Invalid developer keys'),
          backgroundColor: cc.orange);
    }
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Grenmart products",
          "description": "Grenmart cart items",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": double.parse(checkoutInfo!.totalAmount).toInt()
        }
      ],
      "payer": {"email": checkoutInfo.email},
      "back_urls": {
        "failure": "failure.com",
        "pending": "pending.com",
        "success": "success.com"
      },
      "auto_return": "approved"
    });

    var response = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/checkout/preferences?access_token=${selectrdGateaway.clientSecret}'),
        headers: header,
        body: data);

    // print(response.body);
    if (response.statusCode == 201) {
      this.url = jsonDecode(response.body)['init_point'];
      print(response.body);

      return;
    }
    return '';
  }
}
