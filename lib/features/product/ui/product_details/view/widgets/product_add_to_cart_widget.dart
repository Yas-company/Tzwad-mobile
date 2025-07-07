import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/providers/product_details_controller_provider.dart';

class ProductAddToCartWidget extends ConsumerWidget {
  const ProductAddToCartWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalPrice = ref.watch(
      productDetailsControllerProvider.select(
        (value) => value.totalPrice,
      ),
    );
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        color: ColorManager.colorPrimary,
      ),
      height: AppSize.s48,
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => _onPressedAddToCartButton(context, ref),
        child: Row(
          children: [
            const AppSvgPictureWidget(
              assetName: AssetsManager.icTabHome,
              color: ColorManager.colorPureWhite,
            ).marginOnly(
              start: AppPadding.p8,
            ),
            Text(
              'Add to cart',
              textAlign: TextAlign.center,
              style: StyleManager.getSemiBoldStyle(
                color: ColorManager.colorPureWhite,
                fontSize: FontSize.s12,
              ),
            ).marginOnly(
              end: AppPadding.p8,
              start: AppPadding.p8,
            ),
            Container(
              height: AppSize.s48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s8),
                color: ColorManager.blackColor.withOpacity(.10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
              alignment: Alignment.center,
              child: Text(
                '${totalPrice.toStringAsFixed(2)} ${Constants.currency}',
                style: StyleManager.getSemiBoldStyle(
                  color: ColorManager.colorPureWhite,
                  fontSize: FontSize.s12,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressedAddToCartButton(BuildContext context, WidgetRef ref) {
    ref.read(productDetailsControllerProvider.notifier).addProductToCart();
    context.showMessage(
      message: 'Product added to cart',
      messageType: MessageType.success,
    );
  }
}
