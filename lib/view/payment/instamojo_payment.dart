import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gren_mart/service/payment_gateaway_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../cart/payment_status.dart';

class InstamojoPayment extends StatelessWidget {
  InstamojoPayment({
    Key? key,
  }) : super(key: key);
  String? selectedUrl;
  String? prevUrl;
  String? token;
  WebViewController? _controller;

  @override
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
              future: createRequest(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingProgressBar();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  print(selectedUrl);
                  return selectedUrl == null || selectedUrl == ''
                      ? Center(
                          child:
                              Text(asProvider.getString('Connection failed')),
                        )
                      : WebView(
                          initialUrl: selectedUrl as String,
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageStarted: (url) async {},
                          navigationDelegate: (navRequest) async {
                            if (navRequest.url.contains('xgenious')) {
                              if (prevUrl!.contains('status')) {
                                final response =
                                    await http.get(Uri.parse(prevUrl!));
                                if (response.body
                                    .contains('Payment Successful')) {
                                  await Provider.of<ConfirmPaymentService>(
                                          context,
                                          listen: false)
                                      .confirmPayment(context);
                                }
                                if (!response.body
                                    .contains('Payment Successful')) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentStatusView(true)),
                                      (Route<dynamic> route) => false);
                                }
                              }
                              return NavigationDecision.prevent;
                            }
                            prevUrl = navRequest.url;
                            return NavigationDecision.navigate;
                          },
                        );
                }
                return loadingProgressBar();
              }),
        ));
  }

  _checkPaymentStatus(String id, BuildContext context) async {
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Api-Key": "test_b678a7048c8a9e5f69663c2e4fa",
      "X-Auth-Token":
          "wSXg7QepdaLgATQ9tVmR7yCNxYGjoJi1q425-_P7qvM.er2quueQzVx-xajZn9sCva4ASoe8gENF-hLUfZXeEtU"
    };
    // final selectrdGateaway =
    //     Provider.of<PaymentGateawayService>(context, listen: false)
    //         .selectedGateaway!;
    // Map<String, String> header = {
    //   "Accept": "application/json",
    //   "Content-Type": "application/x-www-form-urlencoded",
    //   "X-Api-Key": selectrdGateaway.clientId as String,
    //   "X-Auth-Token": selectrdGateaway.clientSecret as String
    // };

    var response = await http.get(
        Uri.parse("https://test.instamojo.com/api/1.1/payments/$id/"),
        headers: header);

    var realResponse = json.decode(response.body);
    print(realResponse);
    if (realResponse['success'] == true) {
      // if (realResponse["payment"]['status'] == 'Credit') {
      print('instamojo payment successfull');
      await Provider.of<ConfirmPaymentService>(context, listen: false)
          .confirmPayment(context);
      // Provider.of<PlaceOrderService>(context, listen: false)
      //     .makePaymentSuccess(context);

//payment is successful.
//       } else {
//         print('failed');
// //payment failed or pending.
//       }
    } else {
      print("PAYMENT STATUS FAILED");
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaymentStatusView(true)),
          (Route<dynamic> route) => false);
    }
  }

  Future createRequest(BuildContext context) async {
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    final orderId = checkoutInfo!.id;
    print(checkoutInfo.phone.toString().length);
    Map<String, String> body = {
      "amount": checkoutInfo.totalAmount, //amount to be paid
      "purpose": "Grenmart",
      "buyer_name": 'abc',
      "email": checkoutInfo.email,
      "allow_repeated_payments": "true",
      "send_email": "true",
      "phone": '1236521452',
      "send_sms": "false",
      "redirect_url": "https://www.xgenious.com/",
      //Where to redirect after a successful payment.
      "webhook": "https://www.xgenious.com/",
    };

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded",
      "X-Api-Key": "test_b678a7048c8a9e5f69663c2e4fa",
      "X-Auth-Token": "test_41af76995b230611b2c3b72b8cc"
      // "X-Api-Key": selectedGateaway.clientId as String,
      // "X-Auth-Token": token ?? ''
    };

    var resp = await http.post(
        Uri.parse("https://test.instamojo.com/api/1.1/payment-requests/"),
        headers: header,
        body: body);
    print(resp.statusCode);
    if (jsonDecode(resp.body)['success'] == true) {
//If request is successful take the longurl.

      selectedUrl =
          json.decode(resp.body)["payment_request"]['longurl'].toString() +
              "?embed=form";
      return;

//If something is wrong with the data we provided to
//create the Payment_Request. For Example, the email is in incorrect format, the payment_Request creation will fail.
    }
  }
}
