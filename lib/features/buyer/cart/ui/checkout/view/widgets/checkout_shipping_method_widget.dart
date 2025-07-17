import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/shipping_method_enum.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';

class CheckoutShippingMethodWidget extends ConsumerWidget {
  const CheckoutShippingMethodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shippingMethod = ref.watch(
      checkoutControllerProvider.select(
        (value) => value.shippingMethod,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طريقة الاستلام',
          style: StyleManager.getMediumStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        _itemShippingMethod(
          title: 'استلام من الفرع',
          onTap: () => _onPressedPickupButton(ref),
          isSelected: shippingMethod == ShippingMethodEnum.pickUpSite,
        ).marginOnly(
          bottom: AppPadding.p12,
        ),
        _itemShippingMethod(
          title: 'توصيل الى المنزل',
          onTap: () => _onPressedDeliveryButton(ref),
          isSelected: shippingMethod == ShippingMethodEnum.delivery,
        ),
      ],
    );
  }

  Widget _itemShippingMethod({
    required String title,
    required Function onTap,
    required bool isSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.colorWhite1,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: isSelected ? ColorManager.colorSecondary : ColorManager.colorWhite3,
        ),
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Row(
            children: [
              AppSvgPictureWidget(
                assetName: isSelected ? AssetsManager.isSelectedRadioButton : AssetsManager.icUnselectedRadioButton,
              ).marginOnly(end: AppPadding.p8),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isSelected
                      ? StyleManager.getMediumStyle(
                          color: ColorManager.colorBlack1,
                        )
                      : StyleManager.getRegularStyle(
                          color: ColorManager.colorBlack2,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedPickupButton(WidgetRef ref) {
    ref.read(checkoutControllerProvider.notifier).changeShippingMethod(ShippingMethodEnum.pickUpSite);
  }

  _onPressedDeliveryButton(WidgetRef ref) {
    ref.read(checkoutControllerProvider.notifier).changeShippingMethod(ShippingMethodEnum.delivery);
  }
}
