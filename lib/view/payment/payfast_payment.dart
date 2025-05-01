import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/payment_gateaway_service.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../cart/payment_status.dart';

class PayfastPayment extends StatelessWidget {
  PayfastPayment({Key? key}) : super(key: key);
  String? url;
  late WebViewController _controller;
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
            future: waitForIt(context),
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
                onPageFinished: (value) async {
                  if (value.contains('finish')) {
                    bool paySuccess = await verifyPayment(value);
                    if (paySuccess) {
                      await Provider.of<ConfirmPaymentService>(context,
                              listen: false)
                          .confirmPayment(context);
                      return;
                    }
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PaymentStatusView(true)),
                        (Route<dynamic> route) => false);
                  }
                },
              );
            }),
      ),
    );
  }

  waitForIt(BuildContext context) {
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;

    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;
    this.url =
        'https://sandbox.payfast.co.za/eng/process?merchant_id=${selectedGateaway.merchantId}&merchant_key=${selectedGateaway.merchantKey}&amount=${checkoutInfo.totalAmount}&item_name=GrenmartGroceries';
    //   return;
    // }

    // return true;
  }

  Future<bool> verifyPayment(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    print(response.body.contains('successful'));
    return response.body.contains('successful');
  }
}
