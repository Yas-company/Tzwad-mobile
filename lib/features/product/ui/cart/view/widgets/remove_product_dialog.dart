import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/cart/controller/cart_state.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

class RemoveProductDialog extends ConsumerWidget {
  const RemoveProductDialog({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      cartControllerProvider,
      (previous, next) => submitDeleteAccountListener(context, previous, next),
    );
    final state = ref.watch(
      cartControllerProvider.select(
        (value) => value.removeFromCartDataState,
      ),
    );
    return AlertDialog(
      title: Text(
        'Remove Product from cart',
        style: StyleManager.getBoldStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s18,
        ),
      ),
      content: Text(
        'Are you sure you want to remove product from the cart?',
        style: StyleManager.getRegularStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s14,
        ),
      ),
      actions: [
        if (state == DataState.loading) ...{
          const AppLoadingWidget(
            color: ColorManager.colorPrimary,
          ),
        } else ...{
          TextButton(
            onPressed: () => _onPressedCancelButton(context),
            child: Text(
              'Cancel',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorRed,
              ),
            ),
          ),
          TextButton(
            onPressed: () => _onPressedRemoveButton(ref),
            child: Text(
              'Remove',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorPrimary,
              ),
            ),
          ),
        },
      ],
    );
  }

  _onPressedCancelButton(BuildContext context) {
    context.pop();
  }

  _onPressedRemoveButton(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).removeProductFromCart(product);
  }

  void submitDeleteAccountListener(BuildContext context, CartState? previous, CartState next) {
    if (previous?.removeFromCartDataState != next.removeFromCartDataState) {
      if (next.removeFromCartDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.removeFromCartDataState == DataState.success) {
        context.pop();
      }
    }
  }
}
