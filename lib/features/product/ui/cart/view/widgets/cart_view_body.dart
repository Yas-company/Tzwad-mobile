import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

import 'cart_empty_widget.dart';
import 'cart_list_content.dart';

class CartViewBody extends ConsumerWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      cartControllerProvider.select(
        (value) => value.getProductsDataState,
      ),
    );
    final products = ref.watch(
      cartControllerProvider.select(
        (value) => value.products,
      ),
    );
    switch (state) {
      case DataState.loading:
        return CartListContent(
          products: ProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return CartListContent(
          products: products,
          isLoading: false,
        );
      case DataState.empty:
        return const Center(
          child: CartEmptyWidget(),
        );
      default:
        return const SizedBox();
    }
    // if (products.isEmpty) {
    //   return const CartEmptyWidget();
    // } else {
    //   return CartListContent(
    //     products: products,
    //     isLoading: false,
    //   );
    // }
  }
}
