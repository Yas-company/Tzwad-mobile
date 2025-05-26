import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class SearchInitWidget extends StatelessWidget {
  const SearchInitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSvgPictureWidget(
            assetName: AssetsManager.imgSearch,
            height: AppSize.s140,
            width: AppSize.s140,
          ).marginOnly(
            bottom: AppPadding.p20,
          ),
          Text(
            'Search for products, brands and categories',
            textAlign: TextAlign.center,
            style: StyleManager.getMediumStyle(
              color: ColorManager.greyHint,
              fontSize: FontSize.s18,
            ),
          ),
        ],
      ),
    );
  }
}
