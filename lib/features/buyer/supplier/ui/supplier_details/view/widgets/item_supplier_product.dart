import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';

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
              child: const AppImageAssetWidget(
                imagePath: 'assets/images/img_temp.png',
                width: AppSize.s80,
                height: AppSize.s80,
              ),
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    '81.99',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorBlack1,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    '81.99',
                    style: StyleManager.getRegularStyle(
                      color: ColorManager.colorWhite2,
                      fontSize: FontSize.s12,
                    ),
                  ),
                ),
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
                  child: AppButtonWidget(
                    label: '',
                    assetsIcon: AssetsManager.icCart,
                    assetColor: ColorManager.colorWhite1,
                    onPressed: () {},
                    buttonSize: ButtonSize.small,
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
                  child: const Center(
                    child: AppSvgPictureWidget(
                      assetName: AssetsManager.icTabFavorites,
                      width: AppSize.s24,
                      height: AppSize.s24,
                      color: ColorManager.colorSecondary,
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
}
