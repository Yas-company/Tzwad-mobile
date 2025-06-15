import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'form_forget_password_section.dart';

class ForgetPasswordViewBody extends StatelessWidget {
  const ForgetPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(
              AppPadding.p50,
            ),
            Text(
              AppStrings.strForgetPassword.tr(context),
              style: StyleManager.getBoldStyle(
                color: ColorManager.colorBlack1,
                fontSize: FontSize.s28,
              ),
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Text(
              AppStrings.strResetInstructions.tr(context),
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorBlack2,
                fontSize: FontSize.s18,
              ),
            ).marginOnly(
              bottom: AppPadding.p20,
            ),
            const FormForgetPasswordSection(),
          ],
        ),
      ),
    );
  }
}
