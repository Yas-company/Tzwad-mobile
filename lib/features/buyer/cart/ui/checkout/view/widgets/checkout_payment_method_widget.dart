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
import 'package:tzwad_mobile/features/buyer/cart/models/payment_method_enum.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';

class CheckoutPaymentMethodWidget extends ConsumerWidget {
  const CheckoutPaymentMethodWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentMethod = ref.watch(
      checkoutControllerProvider.select(
        (value) => value.paymentMethod,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'طريقة الدفع',
          style: StyleManager.getMediumStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        _itemPaymentMethod(
          title: 'كاش عند الاستلام',
          onTap: () => _onPressedCashButton(ref),
          isSelected: paymentMethod == PaymentMethodEnum.cashOnDelivery,
        ).marginOnly(
          bottom: AppPadding.p12,
        ),
        _itemPaymentMethod(
          title: 'بطاقة ائتمانية',
          onTap: () => _onPressedTapButton(ref),
          isSelected: paymentMethod == PaymentMethodEnum.tap,
          isEnabled: false,
        ),
      ],
    );
  }

  Widget _itemPaymentMethod({
    required String title,
    required Function onTap,
    required bool isSelected,
    bool isEnabled = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isEnabled ? ColorManager.colorWhite1 : ColorManager.colorGrey2,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: isSelected ? ColorManager.colorSecondary : ColorManager.colorWhite3,
        ),
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () {
          if (isEnabled) {
            onTap();
          }
        },
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
              if (!isEnabled) ...{
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey3,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                  padding: const EdgeInsets.all(AppPadding.p2),
                  child: Text(
                    'غير متاحة حاليا',
                    style: StyleManager.getRegularStyle(
                      color: ColorManager.colorBlack2,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
              }
            ],
          ),
        ),
      ),
    );
  }

  _onPressedCashButton(WidgetRef ref) {
    ref.read(checkoutControllerProvider.notifier).changePaymentMethod(PaymentMethodEnum.cashOnDelivery);
  }

  _onPressedTapButton(WidgetRef ref) {
    ref.read(checkoutControllerProvider.notifier).changePaymentMethod(PaymentMethodEnum.tap);
  }
}
