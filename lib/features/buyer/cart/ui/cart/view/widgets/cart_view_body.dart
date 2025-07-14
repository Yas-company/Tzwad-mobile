import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_product_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/providers/cart_controller_provider.dart';

import 'cart_product_list_content.dart';

class CartViewBody extends ConsumerWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      cartControllerProvider.select(
        (value) => value.getCartInfoDataState,
      ),
    );

    final items = ref.watch(
      cartControllerProvider.select(
            (value) => value.cartInfo?.cart?.products ?? [],
      ),
    );

    final failure = ref.read(
      cartControllerProvider.select(
        (value) => value.failure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return  CartProductListContent(
          items: CartProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return CartProductListContent(
          items: items,
          isLoading: false,
        );
      case DataState.failure:
        return Center(
          child: AppFailureWidget(
            failure: failure,
          ),
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'السلة فارغة',
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
