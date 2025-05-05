import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/generic/models/onboarding_model.dart';

class ItemOnboarding extends StatelessWidget {
  const ItemOnboarding({
    super.key,
    required this.onBoarding,
  });

  final OnBoardingModel onBoarding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppImageAssetWidget(
          width: context.getWidth * 0.6,
          height: context.getWidth * 0.6,
          imagePath: onBoarding.imagePath,
          fit: BoxFit.contain,
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        Text(
          onBoarding.title,
          textAlign: TextAlign.center,
          style: StyleManager.getBoldStyle(
            color: ColorManager.colorTitleTexts,
            fontSize: FontSize.s24,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        Text(
          onBoarding.description,
          textAlign: TextAlign.center,
          style: StyleManager.getRegularStyle(
            color: ColorManager.colorTitleTexts,
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }
}
