import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';

import 'form_otp_section.dart';

class OtpViewBody extends StatelessWidget {
  const OtpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = appArgs['phoneNumber'];
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            const Gap(
              AppPadding.p50,
            ),
            const AppImageAssetWidget(
              imagePath: AssetsManager.imgEmail,
              height: 150,
              width: 150,
            ).marginOnly(
              bottom: AppPadding.p20,
            ),
            // const AppSvgPictureWidget(
            //   assetName: AssetsManager.imgVerifyOtp,
            //   height: 200,
            // ).marginOnly(
            //   bottom: AppPadding.p20,
            // ),
            Text(
              AppStrings.strWriteYourCode.tr(context),
              style: StyleManager.getBoldStyle(
                color: ColorManager.colorTitleTexts,
                fontSize: FontSize.s22,
              ),
            ).marginOnly(
              bottom: AppPadding.p4,
            ),
            Text(
              '${AppStrings.strCodeSentNotice.tr(context)} $phoneNumber',
              textAlign: TextAlign.center,
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorBlack1,
              ),
            ).marginOnly(
              bottom: AppPadding.p20,
            ),
            const FormOtpSection(),
          ],
        ),
      ),
    );
  }
}
