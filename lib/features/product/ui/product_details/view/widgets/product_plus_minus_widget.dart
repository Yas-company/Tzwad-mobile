import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/providers/product_details_controller_provider.dart';

class ProductPlusMinusWidget extends ConsumerWidget {
  const ProductPlusMinusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quantity = ref.watch(
      productDetailsControllerProvider.select(
        (value) => value.quantity,
      ),
    );
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: ColorManager.colorPureWhite,
          ),
          height: AppSize.s48,
          // width: context.getWidth / 3,
          child: Row(
            children: [
              Container(
                width: AppSize.s38,
                height: AppSize.s38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.pink.withOpacity(.10),
                ),
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () => _onPressedDecreaseQuantity(ref),
                  icon: const AppSvgPictureWidget(
                    assetName: AssetsManager.icMinus,
                    color: ColorManager.pink,
                  ),
                ),
              ),
              Text(
                quantity.toString(),
                textAlign: TextAlign.center,
                style: StyleManager.getSemiBoldStyle(
                  color: ColorManager.blackColor,
                  fontSize: FontSize.s16,
                ),
              ).marginSymmetric(
                horizontal: AppPadding.p4,
              ),
              Container(
                width: AppSize.s38,
                height: AppSize.s38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.colorPrimary.withOpacity(.10),
                ),
                child: IconButton(
                  onPressed: () => _onPressedIncreaseQuantity(ref),
                  icon: const AppSvgPictureWidget(
                    assetName: AssetsManager.icAdd,
                    color: ColorManager.pink,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _onPressedIncreaseQuantity(WidgetRef ref) {
    ref.read(productDetailsControllerProvider.notifier).increaseQuantity();
  }

  _onPressedDecreaseQuantity(WidgetRef ref) {
    ref.read(productDetailsControllerProvider.notifier).decreaseQuantity();
  }
}
