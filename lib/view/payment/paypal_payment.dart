import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../service/paypal_service.dart';
import '../cart/payment_status.dart';

class PaypalPayment extends StatefulWidget {
  final Function onFinish;

  const PaypalPayment({required this.onFinish});

  @override
  State<StatefulWidget> createState() {
    return PaypalPaymentState();
  }
}

class PaypalPaymentState extends State<PaypalPayment> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var checkoutUrl;
  var executeUrl;
  var accessToken;
  PaypalServices services = PaypalServices();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {
    "symbol": "USD ",
    "decimalDigits": 2,
    "symbolBeforeTheNumber": true,
    "currency": "USD"
  };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      // try {
      accessToken = await services.getAccessToken(context);

      final transactions = getOrderParams(context);
      final res = await services.createPaypalPayment(transactions, accessToken);
      setState(() {
        checkoutUrl = res["approvalUrl"];
        executeUrl = res["executeUrl"];
      });
    });
  }

  Map<String, dynamic> getOrderParams(BuildContext context) {
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": checkoutInfo.totalAmount,
            "currency": "USD",
            // "details": {
            //   "subtotal": cartData.calculateSubtotal().toStringAsFixed(2),
            //   "shipping":checkoutInfo!.,
            //   "shipping_discount": cuponData.cuponDiscount.toStringAsFixed(2),
            // }
          },
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {
        "return_url": "return.example.com",
        "cancel_url": "cancel.example.com"
      }
    };
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
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
            initialUrl: checkoutUrl,
            javascriptMode: JavascriptMode.unrestricted,
            navigationDelegate: (NavigationRequest request) async {
              if (request.url.contains(returnURL)) {
                final uri = Uri.parse(request.url);
                final payerID = uri.queryParameters['PayerID'];
                print(payerID);
                if (payerID != null) {
                  services
                      .executePayment(executeUrl, payerID, accessToken)
                      .then((id) async {
                    // widget.onFinish(id);
                    await Provider.of<ConfirmPaymentService>(context,
                            listen: false)
                        .confirmPayment(context);
                  });
                } else {}
              }
              if (request.url.contains(cancelURL)) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => PaymentStatusView(true)),
                    (Route<dynamic> route) => false);
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBars().appBarTitled(context, '', () async {
          paymentFailedDialogue(context);
        }),
        body: WillPopScope(
            onWillPop: () async {
              paymentFailedDialogue(context);
              return true;
            },
            child: Center(child: Container(child: loadingProgressBar()))),
      );
    }
  }
}
