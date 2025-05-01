import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../service/payment_gateaway_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../cart/payment_status.dart';

class PaystackPayment extends StatelessWidget {
  PaystackPayment({Key? key}) : super(key: key);
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
            future: waitForIt(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return loadingProgressBar();
              }
              if (snapshot.hasData) {
                return Center(
                  child: Text(snapshot.data.toString()),
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                return Center(
                  child: Text(asProvider.getString('Loading failed.')),
                );
              }
              return WebView(
                // onWebViewCreated: ((controller) {
                //   _controller = controller;
                // }),
                onWebResourceError: (error) => showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Text(asProvider.getString('Loading failed!')),
                        content: Text('Failed to load payment page.'),
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
                  // final title = await _controller.currentUrl();
                  // print(title);
                  final uri = Uri.parse(value);
                  final response = await http.get(uri);
                  // if (response.body.contains('PAYMENT ID')) {
                  ;
                  if (response.body.contains('Payment Successful')) {
                    Provider.of<ConfirmPaymentService>(context, listen: false)
                        .confirmPayment(context);
                    return;
                  }
                  if (response.body.contains('Declined')) {
                    await showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title:
                                Text(asProvider.getString('Payment failed!')),
                            content: Text(asProvider
                                .getString('Payment has been cancelled.')),
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
                                  asProvider.getString('Ok'),
                                  style: TextStyle(color: cc.primaryColor),
                                ),
                              )
                            ],
                          );
                        });
                  }
                },
                navigationDelegate: (navRequest) async {
                  print('nav req to .......................${navRequest.url}');
                  if (navRequest.url.contains('success')) {
                    await Provider.of<ConfirmPaymentService>(context,
                            listen: false)
                        .confirmPayment(context);
                    return NavigationDecision.prevent;
                  }
                  if (navRequest.url.contains('failed')) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PaymentStatusView(true)),
                        (Route<dynamic> route) => false);
                  }
                  return NavigationDecision.navigate;
                },

                // javascriptChannels: <JavascriptChannel>[
                //   // Set Javascript Channel to WebView
                //   JavascriptChannel(
                //       name: 'same',
                //       onMessageReceived: (javMessage) {
                //         print(javMessage.message);
                //         print('...........................................');
                //       }),
                // ].toSet(),
              );
            }),
      ),
    );
  }

  Future waitForIt(BuildContext context) async {
    final uri = Uri.parse('https://api.paystack.co/transaction/initialize');
    final selectedGateway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${selectedGateway.secretKey}",
    };
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;
    print(orderId);
    // final orderId = Random().nextInt(23000).toInt();
    final response = await http.post(uri,
        headers: header,
        body: jsonEncode({
          "amount": double.parse(checkoutInfo.totalAmount).toInt() * 100,
          "currency": "NGN",
          "email": checkoutInfo.email,
          "reference_id": orderId.toString(),
          "callback_url": "http://success.com",
          "metadata": {"cancel_action": "http://failed.com"}
        }));
    print(response.body);
    if (response.statusCode == 200) {
      this.url = jsonDecode(response.body)['data']['authorization_url'];
      print(url);
      return;
    }
    snackBar(context, 'Loading failed', backgroundColor: cc.orange);
    return jsonDecode(response.body)['message'];
    // print(response.statusCode);
    // if (response.statusCode == 201) {
    // this.url =
    //     'https://sandbox.payfast.co.za/eng/process?merchant_id=${selectedGateaway.merchantId}&merchant_key=${selectedGateaway.merchantKey}&amount=$amount&item_name=GrenmartGroceries';
    // //   return;
    // // }

    // return true;
  }
}
