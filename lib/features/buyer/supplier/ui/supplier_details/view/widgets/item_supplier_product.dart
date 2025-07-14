import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/controller/supplier_details_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/providers/supplier_details_controller_provider.dart';

class ItemSupplierProduct extends StatelessWidget {
  const ItemSupplierProduct({
    super.key,
    required this.product,
  });

  final SupplierProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        color: ColorManager.colorWhite1,
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: AppSize.s100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s8),
                color: ColorManager.colorWhite3,
              ),
              alignment: Alignment.center,
              child:  AppNetworkImageWidget(
                url: product.image ?? '',
                width: AppSize.s80,
                height: AppSize.s80,
                radius: AppSize.s8,
              ),
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    product.price ?? '',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorBlack1,
                    ),
                  ),
                ),
                // Flexible(
                //   child: Text(
                //     product.priceBeforeDiscount ?? '',
                //     style: StyleManager.getRegularStyle(
                //       color: ColorManager.colorWhite2,
                //       fontSize: FontSize.s12,
                //     ),
                //   ),
                // ),
              ],
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Text(
              product.name ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
              ),
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Row(
              children: [
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) {
                      ref.listen(
                        supplierDetailsControllerProvider,
                        (previous, next) => submitAddToCartListener(context, previous, next),
                      );
                      return AppButtonWidget(
                        label: '',
                        assetsIcon: AssetsManager.icCart,
                        assetColor: ColorManager.colorWhite1,
                        onPressed: () => _onPressedAddToCartButton(ref, product),
                        buttonSize: ButtonSize.small,
                        isLoading: product.isLoading,
                      );
                    },
                  ),
                ),
                const Gap(
                  AppPadding.p8,
                ),
                Container(
                  width: AppSize.s48,
                  height: AppSize.s48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                    color: ColorManager.colorSecondary.withAlpha(20),
                    border: Border.all(
                      color: ColorManager.colorSecondary,
                    ),
                  ),
                  child: AppRippleWidget(
                    radius: AppSize.s8,
                    onTap: () => _oPressedAddToFavoritesButton(context),
                    child: const Center(
                      child: AppSvgPictureWidget(
                        assetName: AssetsManager.icTabFavorites,
                        width: AppSize.s24,
                        height: AppSize.s24,
                        color: ColorManager.colorSecondary,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  _onPressedAddToCartButton(WidgetRef ref, SupplierProductModel product) {
    ref.read(supplierDetailsControllerProvider.notifier).addToCart(product);
  }

  _oPressedAddToFavoritesButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
    // ref.read(supplierDetailsControllerProvider.notifier).toggleFavorite(product);
  }

  submitAddToCartListener(BuildContext context, SupplierDetailsState? previous, SupplierDetailsState next) {
    // if (previous?.submitLoginDataState != next.submitLoginDataState) {
    //   if (next.submitLoginDataState == DataState.failure) {
    //     context.showMessage(
    //       message: next.failure?.message ?? '',
    //     );
    //   } else if (next.submitLoginDataState == DataState.success) {
    //     context.pushReplacementNamed(AppRoutes.homeBuyerRoute);
    //   }
    // }
  }
}
