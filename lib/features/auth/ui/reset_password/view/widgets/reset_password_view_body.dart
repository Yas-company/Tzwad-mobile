import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'form_reset_password_section.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key});

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
              AppStrings.strResetPassword.tr(context),
              style: StyleManager.getBoldStyle(
                color: ColorManager.colorBlack1,
                fontSize: FontSize.s28,
              ),
            ).marginOnly(
              bottom: AppPadding.p8,
            ),
            Text(
              AppStrings.strResetPasswordDescription.tr(context),
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorBlack2,
                fontSize: FontSize.s18,
              ),
            ).marginOnly(
              bottom: AppPadding.p20,
            ),
            const FormResetPasswordSection(),
          ],
        ),
      ),
    );
  }
}
