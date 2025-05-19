import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

import 'cart_empty_widget.dart';
import 'cart_list_content.dart';

class CartViewBody extends ConsumerWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(
      cartControllerProvider.select(
        (value) => value.products,
      ),
    );
    if (products.isEmpty) {
      return const CartEmptyWidget();
    } else {
      return CartListContent(
        products: products,
        isLoading: false,
      );
    }
  }
}
