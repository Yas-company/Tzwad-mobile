import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class SupplierRatingWidget extends StatelessWidget {
  const SupplierRatingWidget({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p4,
        vertical: AppPadding.p2,
      ),
      decoration: BoxDecoration(
        color: ColorManager.colorSecondary,
        borderRadius: BorderRadius.circular(
          AppSize.s10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AppSvgPictureWidget(
            assetName: AssetsManager.icStar,
            width: AppSize.s12,
            height: AppSize.s12,
          ).marginOnly(
            end: AppPadding.p2,
          ),
          Text(
            rating.toString(),
            style: StyleManager.getBoldStyle(
              color: ColorManager.colorWhite1,
              fontSize: FontSize.s12,
            ),
          ).marginOnly(
            top: AppPadding.p2,
          ),
        ],
      ),
    );
  }
}
