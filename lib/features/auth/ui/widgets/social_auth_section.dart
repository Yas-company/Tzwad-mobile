import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (Platform.isAndroid) ...{
          AppButtonWidget(
            height: AppSize.s44,
            label: 'Login with Google',
            onPressed: () {},
            buttonType: ButtonType.outline,
            borderColor: ColorManager.greyBorder,
            textColor: ColorManager.greyParagraph,
            assetsIcon: AssetsManager.icGoogle,
          ).marginOnly(
            bottom: AppPadding.p16,
          ),
        },
        if (Platform.isIOS) ...{
          AppButtonWidget(
            height: AppSize.s44,
            label: 'Login with Apple',
            onPressed: () {},
            buttonType: ButtonType.outline,
            borderColor: ColorManager.greyBorder,
            textColor: ColorManager.greyParagraph,
            assetsIcon: AssetsManager.icApple,
          ).marginOnly(
            bottom: AppPadding.p16,
          ),
        },
        AppButtonWidget(
          height: AppSize.s44,
          label: 'Login with Facebook',
          onPressed: () {},
          buttonType: ButtonType.outline,
          borderColor: ColorManager.greyBorder,
          textColor: ColorManager.greyParagraph,
          assetsIcon: AssetsManager.icFacebook,
        ),
      ],
    );
  }
}
