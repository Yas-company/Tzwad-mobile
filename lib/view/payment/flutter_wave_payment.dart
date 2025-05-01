import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:flutterwave_standard/models/subaccount.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../service/checkout_service.dart';
import '../../service/confirm_payment_service.dart';
import '../../service/payment_gateaway_service.dart';
import '../cart/payment_status.dart';
import '../utils/constant_styles.dart';

class FlutterWavePayment {
  late BuildContext context;
  String currency = 'USD';

  void makePayment(BuildContext context) async {
    this.context = context;
    _handlePaymentInitialization(context);
  }

  _handlePaymentInitialization(BuildContext context) async {
    final checkoutData =
        Provider.of<CheckoutService>(context, listen: false).checkoutModel;
    final selectrdGateaway =
        Provider.of<PaymentGateawayService>(context, listen: false)
            .selectedGateaway!;
    if (selectrdGateaway.publicKey == null ||
        selectrdGateaway.secretKey == null) {
      snackBar(context, asProvider.getString('Invalid developer keys'));
    }
    String publicKey = selectrdGateaway.publicKey ?? '';

    final style = FlutterwaveStyle(
      appBarText: asProvider.getString("Flutterwave payment"),
      buttonColor: cc.primaryColor,
      buttonTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      appBarColor: cc.pureWhite,
      dialogCancelTextStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 17,
      ),
      dialogContinueTextStyle: TextStyle(
        color: cc.primaryColor,
        fontSize: 17,
      ),
      mainBackgroundColor: Colors.white,
      mainTextStyle:
          const TextStyle(color: Colors.black, fontSize: 17, letterSpacing: 2),
      dialogBackgroundColor: Colors.white,
      appBarIcon: Icon(Icons.arrow_back, color: cc.blackColor),
      buttonText:
          asProvider.getString("Pay") + " \$ ${checkoutData!.totalAmount}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
        name: checkoutData.name,
        phoneNumber: checkoutData.phone,
        email: checkoutData.email);

    final subAccounts = [
      SubAccount(
          id: "RS_1A3278129B808CB588B53A14608169AD",
          transactionChargeType: "flat",
          transactionPercentage: 25),
      SubAccount(
          id: "RS_C7C265B8E4B16C2D472475D7F9F4426A",
          transactionChargeType: "flat",
          transactionPercentage: 50)
    ];

    final checkoutInfo = Provider.of<CheckoutService>(context, listen: false);
    final orderId = checkoutInfo.checkoutModel!.id;
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        style: style,
        publicKey: publicKey,
        currency: currency,
        txRef: const Uuid().v1(),
        amount: checkoutData.totalAmount,
        customer: customer,
        subAccounts: subAccounts,
        paymentOptions: "card, payattitude",
        customization: Customization(title: "Test Payment"),
        redirectUrl: "https://www.google.com",
        isTestMode: false);
    var response = await flutterwave.charge().catchError((_) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaymentStatusView(true)),
          (Route<dynamic> route) => false);
    });
    if (response.success ?? false) {
      await Provider.of<ConfirmPaymentService>(context, listen: false)
          .confirmPayment(context);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => PaymentStatusView(true)),
          (Route<dynamic> route) => false);
    }
  }
}
