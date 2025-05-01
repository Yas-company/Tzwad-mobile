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

class MidtransPayment extends StatelessWidget {
  MidtransPayment({Key? key}) : super(key: key);
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
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onPageFinished: (value) async {
                  print('on progress.........................$value');
                  if (value.contains('success')) {
                    print('closing payment......');
                    print('closing payment.............');
                    print('closing payment...................');
                    print('closing payment..........................');
                    await Provider.of<ConfirmPaymentService>(context,
                            listen: false)
                        .confirmPayment(context);
                  }
                },
              );
            }),
      ),
    );
  }

  waitForIt(BuildContext context) async {
    final selectrdGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    print('here');
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;
    final url =
        Uri.parse('https://app.sandbox.midtrans.com/snap/v1/transactions');
    final selectedGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    final username = selectedGateaway.serverKey;
    final password = selectedGateaway.clientKey;
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final header = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": basicAuth,
      // Above is API server key for the Midtrans account, encoded to base64
    };
    final response = await http.post(url,
        headers: header,
        body: jsonEncode({
          "transaction_details": {
            "order_id": "$orderId",
            "gross_amount":
                double.parse(checkoutInfo.totalAmount).toInt().toString()
          },
          "credit_card": {"secure": true},
          "customer_details": {
            "first_name": checkoutInfo.name,
            "email": checkoutInfo.email,
            "phone": checkoutInfo.phone,
          }
        }));
    print(response.body);
    if (response.statusCode == 201) {
      this.url = jsonDecode(response.body)['redirect_url'];
      return;
    }

    return true;
  }
}
