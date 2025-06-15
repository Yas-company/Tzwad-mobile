import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register/view/widgets/form_register_section.dart';
import 'package:tzwad_mobile/features/auth/ui/widgets/social_auth_section.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.strRegister.tr(context),
              style: StyleManager.getBoldStyle(
                color: ColorManager.colorBlack1,
                fontSize: FontSize.s28,
              ),
            ),
            Text(
              AppStrings.strNewUser.tr(context),
              style: StyleManager.getRegularStyle(
                color: ColorManager.colorBlack2,
                fontSize: FontSize.s20,
              ),
            ).marginOnly(
              bottom: AppPadding.p16,
            ),
            const FormRegisterSection().marginOnly(
              bottom: AppPadding.p16,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                AppStrings.strOrRegisterThrough.tr(context),
                style: StyleManager.getRegularStyle(
                  color: ColorManager.colorBlack2,
                  fontSize: FontSize.s16,
                ),
              ),
            ).marginOnly(
              bottom: AppPadding.p16,
            ),
            const SocialAuthSection().marginOnly(
              bottom: AppPadding.p16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.strAlreadyHaveAccount.tr(context),
                  style: StyleManager.getRegularStyle(
                    color: ColorManager.colorWhite2,
                  ),
                ),
                AppRippleWidget(
                  onTap: () => _onPressedLoginButton(context),
                  child: Text(
                    AppStrings.strLogin.tr(context),
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorPrimary,
                      fontSize: FontSize.s16,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _onPressedLoginButton(BuildContext context) {
    context.pop();
  }
}
