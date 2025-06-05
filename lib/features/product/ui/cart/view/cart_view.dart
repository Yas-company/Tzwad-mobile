import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/ui/cart/controller/cart_state.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: const CartViewBody(),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          ref.listen(
            cartControllerProvider,
            (previous, next) => submitCheckoutListener(context, previous, next),
          );
          final getProductsState = ref.watch(
            cartControllerProvider.select(
              (value) => value.getProductsDataState,
            ),
          );
          final checkoutState = ref.watch(
            cartControllerProvider.select(
              (value) => value.checkoutDataState,
            ),
          );
          if (getProductsState == DataState.success) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: AppButtonWidget(
                label: 'Checkout',
                onPressed: () => _onPressedCheckoutButton(ref, context),
                isLoading: checkoutState == DataState.loading,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  _onPressedCheckoutButton(WidgetRef ref, BuildContext context) {
    ref.read(cartControllerProvider.notifier).checkout();
  }

  void submitCheckoutListener(BuildContext context, CartState? previous, CartState next) {
    if (previous?.checkoutDataState != next.checkoutDataState) {
      if (next.checkoutDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.checkoutDataState == DataState.success) {
        context.showMessage(
          messageType: MessageType.success,
          message: 'Checkout successfully',
        );
      }
    }
  }
}
