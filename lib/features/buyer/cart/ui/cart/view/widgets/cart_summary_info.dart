import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_info_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/providers/cart_controller_provider.dart';

import 'cart_summary_info_content.dart';

class CartSummaryInfo extends ConsumerWidget {
  const CartSummaryInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      cartControllerProvider.select(
            (value) => value.getCartInfoDataState,
      ),
    );

    final cartInfo = ref.watch(
      cartControllerProvider.select(
            (value) => value.cartInfo,
      ),
    );

    final failure = ref.read(
      cartControllerProvider.select(
            (value) => value.failure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return CartSummaryInfoContent(
          cartInfo: CartInfoModel.fake(),
          isLoading: true,
        );
      case DataState.success:
        if(cartInfo == null) {
          return const SizedBox();
        }
        return CartSummaryInfoContent(
          cartInfo: cartInfo,
        );
      default:
        return const SizedBox();
    }
  }

}
