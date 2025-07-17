import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'checkout_address_widget.dart';
import 'checkout_coupon_widget.dart';
import 'checkout_payment_method_widget.dart';
import 'checkout_shipping_method_widget.dart';

class CheckoutViewBody extends StatelessWidget {
  const CheckoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            CheckoutShippingMethodWidget(),
            Gap(AppPadding.p16),
            CheckoutAddressWidget(),
            Gap(AppPadding.p16),
            CheckoutPaymentMethodWidget(),
            Gap(AppPadding.p20),
            CheckoutCouponWidget(),
          ],
        ),
      ),
    );
  }
}
