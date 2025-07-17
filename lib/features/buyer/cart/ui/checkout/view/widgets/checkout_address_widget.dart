import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/view/checkout_addresses_bottom_sheet.dart';

class CheckoutAddressWidget extends ConsumerWidget {
  const CheckoutAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      checkoutControllerProvider.select(
        (value) => value.getAddressesDataState == DataState.loading,
      ),
    );

    final selectAddress = ref.watch(
      checkoutControllerProvider.select(
        (value) => value.selectAddress,
      ),
    );
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        padding: const EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: ColorManager.colorWhite4,
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'العنوان',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
                fontSize: FontSize.s16,
              ),
            ).marginOnly(
              bottom: AppPadding.p16,
            ),
            const AppImageAssetWidget(
              imagePath: 'assets/images/img_temp_map.png',
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ).marginOnly(
              bottom: AppPadding.p16,
            ),
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: ColorManager.colorPrimary,
                  size: AppSize.s18,
                ).marginOnly(
                  end: AppPadding.p8,
                ),
                Expanded(
                  child: Text(
                    selectAddress?.name ?? '',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorPrimary,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
                AppRippleWidget(
                  onTap: () => _onPressedChangeAddressButton(context),
                  child: Text(
                    'تغيير العنوان',
                    style: StyleManager.getRegularStyle(
                      color: ColorManager.colorPrimary,
                    ).copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Text(
              selectAddress?.city ?? '',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
              ),
            ).marginOnly(
              bottom: AppPadding.p4,
            ),
            Text(
              selectAddress?.street ?? '',
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorBlack2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPressedChangeAddressButton(BuildContext context) {
    CheckoutAddressesBottomSheet.show(context);
  }
}
