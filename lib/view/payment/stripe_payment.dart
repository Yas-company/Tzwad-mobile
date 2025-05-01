import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import '../../service/payment_gateaway_service.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../cart/payment_status.dart';

class StripePayment {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context) async {
    if (Provider.of<PaymentGateawayService>(context, listen: false)
                .selectedGateaway!
                .publicKey ==
            null ||
        Provider.of<PaymentGateawayService>(context, listen: false)
                .selectedGateaway!
                .secretKey ==
            null) {
      snackBar(context, asProvider.getString('Invalid developer keys'));
      return;
    }
    // Stripe.publishableKey =
    //     "";
    Stripe.publishableKey =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!
            .publicKey
            .toString();
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;
    try {
      paymentIntent =
          await createPaymentIntent(context, checkoutInfo.totalAmount, 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  // applePay: const PaymentSheetApplePay(merchantCountryCode: '+92',),
                  // googlePay: const PaymentSheetGooglePay(testEnv: true, currencyCode: "US", merchantCountryCode: "+92"),
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Grenmart'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        await Provider.of<ConfirmPaymentService>(context, listen: false)
            .confirmPayment(context);

        paymentIntent = null;
      }).onError((error, stackTrace) async {
        print('Error is:--->$error $stackTrace');
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => PaymentStatusView(true)),
            (Route<dynamic> route) => false);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(asProvider.getString('Payment failed')),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => PaymentStatusView(true)),
                      (Route<dynamic> route) => false),
                  child: Text(
                    asProvider.getString('Ok'),
                    style: TextStyle(color: cc.primaryColor),
                  ),
                )
              ],
            );
          });
    } catch (e) {
      print('$e');
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(asProvider.getString('Payment failed')),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => PaymentStatusView(true)),
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
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(
      BuildContext context, String amount, String currency) async {
    final checkoutInfo =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final orderId = checkoutInfo!.id;
    final selectrdGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    // try {
    print(checkoutInfo.totalAmount);
    Map<String, dynamic> body = {
      'amount':
          (double.parse(checkoutInfo.totalAmount).toInt() * 100).toString(),
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer ${selectrdGateaway.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    // ignore: avoid_print
    print('Payment Intent Body->>> ${response.body}');
    return jsonDecode(response.body);
    // } catch (err) {
    //   // ignore: avoid_print
    //   print('err charging user: ${err.toString()}');
    // }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
