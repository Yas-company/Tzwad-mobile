import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/service/cart_data_service.dart';
import 'package:gren_mart/service/checkout_service.dart';
import 'package:gren_mart/service/confirm_payment_service.dart';
import 'package:provider/provider.dart';
import '../../view/home/home_front.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/constant_styles.dart';
import '../order/order_details.dart';
import '../utils/text_themes.dart';

class PaymentStatusView extends StatelessWidget {
  static const routeName = 'pament status';
  bool isError;
  int? trackId;
  PaymentStatusView(this.isError, {this.trackId, Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    if (isError &&
        Provider.of<CheckoutService>(context, listen: false).checkoutModel !=
            null) {
      Provider.of<ConfirmPaymentService>(context, listen: false)
          .reportPaymentFailed(
              Provider.of<CheckoutService>(context, listen: false)
                  .checkoutModel!
                  .id);
    }
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (!isError) {
            Provider.of<CartDataService>(context, listen: false).emptyCart();
            Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
            return true;
          }
          Navigator.of(context).pushReplacementNamed(HomeFront.routeName);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(17.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        child: Image.asset(isError
                            ? 'assets/images/payment_error.png'
                            : 'assets/images/payment_success.png'),
                      ),
                      const SizedBox(height: 45),
                      Text(
                        isError
                            ? asProvider.getString('Oops!')
                            : asProvider.getString('Payment successful!'),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: ConstantColors().titleTexts,
                        ),
                      ),
                      const SizedBox(height: 15),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: isError
                              ? asProvider.getString(
                                  "We're getting problems with your payment methods and we couldn't proceed your order.")
                              : asProvider.getString(
                                  "Your order has been successful! You'll receive ordered items in 3-5 days. Your order ID is"),
                          style: TextThemeConstrants.paragraphText,
                          children: <TextSpan>[
                            if (!isError)
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Provider.of<CartDataService>(context,
                                              listen: false)
                                          .emptyCart();
                                      Navigator.of(context)
                                          .push(MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            OrderDetails(
                                                Provider.of<CheckoutService>(
                                                        context,
                                                        listen: false)
                                                    .checkoutModel!
                                                    .id
                                                    .toString()),
                                      ));
                                    },
                                  text:
                                      ' #${Provider.of<CheckoutService>(context, listen: false).checkoutModel!.id}',
                                  style: TextStyle(color: cc.primaryColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              !(isError)
                  ? customRowButton(
                      context,
                      asProvider.getString('Back to home'),
                      asProvider.getString('Track your order'), () {
                      Provider.of<CartDataService>(context, listen: false)
                          .emptyCart();
                      Navigator.of(context)
                          .pushReplacementNamed(HomeFront.routeName);
                    }, () {
                      Provider.of<CartDataService>(context, listen: false)
                          .emptyCart();
                      Navigator.of(context).push(MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            OrderDetails(trackId!.toString()),
                      ));
                    })
                  : customContainerButton(
                      asProvider.getString('Back to home'), screenWidth - 50,
                      () {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeFront.routeName);
                    }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
