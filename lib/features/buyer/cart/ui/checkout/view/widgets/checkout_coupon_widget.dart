import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_dashed_border_container_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';

class CheckoutCouponWidget extends ConsumerWidget {
  const CheckoutCouponWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const AppSvgPictureWidget(
          assetName: AssetsManager.icCoupon,
        ).marginOnly(
          end: AppPadding.p8,
        ),
        Text(
          'كوبون',
          style: StyleManager.getBoldStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          end: AppPadding.p8,
        ),
        Expanded(
          child: AppDashedBorderContainerWidget(
            borderRadius: BorderRadius.circular(AppSize.s8),
            borderColor: ColorManager.colorPrimary,
            child: AppTextFieldWidget(
              hintText: '',
              onChanged: (value) => ref.read(checkoutControllerProvider.notifier).changeCoupon(value),
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: const InputDecoration(
                hintText: 'اكتب الكود هنا',
                fillColor: Colors.transparent,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
