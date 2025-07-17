import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/buyer/address/models/address_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';

class CheckoutAddressesBottomSheet extends StatelessWidget {
  const CheckoutAddressesBottomSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => const CheckoutAddressesBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'اختر العنوان',
          style: StyleManager.getBoldStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p16,
          start: AppPadding.p16,
          end: AppPadding.p16,
        ),
        Consumer(
          builder: (context, ref, child) {
            final selectAddresses = ref.watch(
              checkoutControllerProvider.select(
                (value) => value.selectAddress,
              ),
            );

            final addresses = ref.watch(
              checkoutControllerProvider.select(
                (value) => value.addresses,
              ),
            );
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => _itemCheckoutAddress(
                title: addresses[index].name ?? '',
                subtitle: addresses[index].city ?? ' - ${addresses[index].street ?? ''}',
                onTap: () => _onPressedChangeAddressButton(
                  context,
                  ref,
                  addresses[index],
                ),
                isSelected: addresses[index].id == selectAddresses?.id,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
              ),
              separatorBuilder: (context, index) => const Gap(AppPadding.p16),
              itemCount: addresses.length,
            );
          },
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        AppRippleWidget(
          onTap: () => _onPressedAddAddressButton(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppPadding.p12,
              horizontal: AppPadding.p16,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: ColorManager.colorSecondary,
                ).marginOnly(
                  end: AppPadding.p8,
                ),
                Text(
                  'اضافة عنوان',
                  style: StyleManager.getRegularStyle(
                    color: ColorManager.colorBlack2,
                  ).copyWith(
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
          ),
        ).marginOnly(
          bottom: AppPadding.p20,
        ),
      ],
    );
  }

  Widget _itemCheckoutAddress({
    required String title,
    required String subtitle,
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
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Row(
            children: [
              AppSvgPictureWidget(
                assetName: isSelected ? AssetsManager.isSelectedRadioButton : AssetsManager.icUnselectedRadioButton,
              ).marginOnly(end: AppPadding.p8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.getMediumStyle(
                        color: ColorManager.colorBlack1,
                      ),
                    ),
                    Text(subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.getRegularStyle(
                          color: ColorManager.colorBlack2,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedAddAddressButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }

  _onPressedChangeAddressButton(BuildContext context, WidgetRef ref, AddressModel address) {
    ref.read(checkoutControllerProvider.notifier).changeAddress(address);
    context.pop();
  }
}
