import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/controller/cart_controller.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/controller/cart_state.dart';

final cartControllerProvider = NotifierProvider.autoDispose<CartController, CartState>(
  () {
    return CartController();
  },
);
