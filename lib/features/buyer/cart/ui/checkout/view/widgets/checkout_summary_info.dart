import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_currency_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_info_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/controller/checkout_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/checkout/providers/checkout_controller_provider.dart';

class CheckoutSummaryInfo extends StatelessWidget {
  const CheckoutSummaryInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartInfo = appArgs['cartInfo'] as CartInfoModel;
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.colorWhite1,
        boxShadow: [
          ColorManager.genericBoxShadow,
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _requirementsWidget(cartInfo).marginOnly(
                bottom: AppPadding.p16,
              ),
              // Total Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'الاجمالي',
                      style: StyleManager.getMediumStyle(color: ColorManager.colorBlack2, fontSize: FontSize.s16),
                    ),
                  ),
                  Text(
                    cartInfo.total.toString(),
                    style: StyleManager.getBoldStyle(color: ColorManager.colorBlack1, fontSize: FontSize.s16),
                  ).marginOnly(
                    start: AppPadding.p8,
                    end: AppPadding.p4,
                  ),
                  const AppCurrencyWidget(),
                ],
              ).marginOnly(
                bottom: AppPadding.p16,
              ),

              // Total Discount
              _discountWidget(cartInfo),

              // Final Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'السعر النهائي',
                      style: StyleManager.getMediumStyle(
                        color: ColorManager.colorBlack2,
                        fontSize: FontSize.s16,
                      ),
                    ),
                  ),
                  Text(
                    cartInfo.total.toString(),
                    style: StyleManager.getBoldStyle(
                      color: ColorManager.colorBlack2,
                      fontSize: FontSize.s16,
                    ),
                  ).marginOnly(
                    start: AppPadding.p8,
                    end: AppPadding.p4,
                  ),
                  const AppCurrencyWidget(
                    color: ColorManager.colorBlack2,
                  ),
                ],
              ).marginOnly(
                bottom: AppPadding.p16,
              ),

              Row(
                children: [
                  Expanded(
                    child: AppButtonWidget(
                      label: 'اضافة اصناف',
                      onPressed: () => _onPressedAddItemsButton(context),
                    ),
                  ),
                  const Gap(AppPadding.p12),
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        ref.listen(
                          checkoutControllerProvider,
                          (previous, next) => submitCheckoutListener(context, previous, next),
                        );
                        final isLoading = ref.watch(
                          checkoutControllerProvider.select(
                            (value) => value.checkoutDataState == DataState.loading,
                          ),
                        );
                        return AppButtonWidget(
                          label: 'تأكيد الطلب',
                          onPressed: () => _onPressedCheckoutButton(ref),
                          buttonType: ButtonType.outline,
                          isLoading: isLoading,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _requirementsWidget(CartInfoModel cartInfo) {
    final items = cartInfo.supplierRequirements ?? [];
    return Column(
      children: [
        for (var item in items) ...{
          if ((item.requiredAmount ?? 0) > 0) ...{
            Container(
              decoration: BoxDecoration(
                color: ColorManager.colorSecondary.withAlpha(20),
                borderRadius: BorderRadius.circular(AppSize.s4),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p8,
                vertical: AppPadding.p4,
              ),
              child: Row(
                children: [
                  const AppSvgPictureWidget(
                    assetName: AssetsManager.isAlterCircle,
                    width: AppSize.s24,
                    height: AppSize.s24,
                  ).marginOnly(
                    end: AppPadding.p8,
                  ),
                  Expanded(
                    child: Text(
                      '${item.requiredAmount} ريال متبقيين لتكملة الحد الادنى للطلب',
                    ),
                  ),
                ],
              ),
            ),
          }
        },
      ],
    );
  }

  Widget _discountWidget(CartInfoModel cartInfo) {
    if ((cartInfo.totalDiscount ?? 0) <= 0) {
      return const SizedBox();
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'اجمالي الخصم',
          style: StyleManager.getMediumStyle(
            color: ColorManager.colorBlack2,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          end: AppPadding.p8,
        ),
        const AppSvgPictureWidget(
          assetName: AssetsManager.icDiscount,
          width: AppSize.s20,
          height: AppSize.s20,
        ),
        const Spacer(),
        Text(
          cartInfo.totalDiscount.toString(),
          style: StyleManager.getBoldStyle(color: ColorManager.colorBlack1, fontSize: FontSize.s16),
        ).marginOnly(
          start: AppPadding.p8,
          end: AppPadding.p4,
        ),
        const AppCurrencyWidget(),
      ],
    ).marginOnly(
      bottom: AppPadding.p16,
    );
  }

  _onPressedAddItemsButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }

  _onPressedCheckoutButton(WidgetRef ref) {
    ref.read(checkoutControllerProvider.notifier).checkout();
  }

  void submitCheckoutListener(BuildContext context, CheckoutState? previous, CheckoutState next) {
    if (previous?.checkoutDataState != next.checkoutDataState) {
      if (next.checkoutDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.checkoutDataState == DataState.success) {
        context.pop();
        context.pop();
        context.showMessage(
          message: 'تم تأكيد الطلب بنجاح',
          messageType: MessageType.success
        );
      }
    }
  }
}
