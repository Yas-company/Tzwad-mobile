import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButtonWidget(
            label: 'الفيسبوك',
            onPressed: () {},
            buttonType: ButtonType.outline,
            borderColor: ColorManager.colorWhite3,
            textColor: ColorManager.colorWhite2,
            assetsIcon: AssetsManager.icFacebook,
            buttonSize: ButtonSize.small,
          ),
        ),
        const Gap(
          AppPadding.p16,
        ),
        if (Platform.isAndroid) ...{
          Expanded(
            child: AppButtonWidget(
              label: 'حساب ابل',
              onPressed: () {},
              buttonType: ButtonType.outline,
              borderColor: ColorManager.colorWhite3,
              textColor: ColorManager.colorWhite2,
              assetsIcon: AssetsManager.icGoogle,
              buttonSize: ButtonSize.small,
            ),
          )
        },
        if (Platform.isIOS) ...{
          Expanded(
            child: AppButtonWidget(
              label: 'حساب ابل',
              onPressed: () {},
              buttonType: ButtonType.outline,
              borderColor: ColorManager.colorWhite3,
              textColor: ColorManager.colorWhite2,
              assetsIcon: AssetsManager.icApple,
              buttonSize: ButtonSize.small,
            ),
          ),
        },
      ],
    );
  }
}
