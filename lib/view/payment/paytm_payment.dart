import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_styles.dart';
import '../cart/payment_status.dart';

class PaytmPayment extends StatelessWidget {
  PaytmPayment({Key? key}) : super(key: key);
  WebViewController? _controller;
  String? html;
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
        child: WebView(
          onWebViewCreated: (controller) {
            _controller = controller;
            controller.loadHtmlString(
                Provider.of<CheckoutService>(context, listen: false)
                    .paytmResponse as String);
          },
          initialUrl: "url",
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (value) {
            if (value.contains('success')) {
              Provider.of<ConfirmPaymentService>(context, listen: false)
                  .confirmPayment(context);
            }
          },
          navigationDelegate: (navData) {
            if (navData.url.contains('success')) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => PaymentStatusView(false)),
                  (Route<dynamic> route) => false);
              return NavigationDecision.prevent;
            }
            if (navData.url.contains('failed')) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => PaymentStatusView(true)),
                  (Route<dynamic> route) => false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }
}

Future<bool> verifyPayment(String url) async {
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  print(response.body.contains('successful'));
  return response.body.contains('successful');
}
