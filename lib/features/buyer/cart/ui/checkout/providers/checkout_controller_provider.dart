import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/controller/checkout_controller.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/controller/checkout_state.dart';

final checkoutControllerProvider = NotifierProvider.autoDispose<CheckoutController, CheckoutState>(
  () {
    return CheckoutController();
  },
);
