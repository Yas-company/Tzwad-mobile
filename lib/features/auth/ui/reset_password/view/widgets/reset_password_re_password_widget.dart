import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/hooks/reset_password_re_password_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/providers/reset_password_controller_provider.dart';

class ResetPasswordRePasswordWidget extends HookConsumerWidget {
  const ResetPasswordRePasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      resetPasswordControllerProvider.select(
        (value) => value.rePasswordValidationMessage,
      ),
    );
    final obscureText = ref.watch(
      resetPasswordControllerProvider.select(
        (value) => value.obscureTextRePassword,
      ),
    );
    final passwordController = useResetPasswordRePasswordController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strConfirmNewPassword.tr(context),
          style: StyleManager.getRegularStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: passwordController,
          hintText: AppStrings.strHintPassword.tr(context),
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          obscureText: obscureText,
          suffixIcon: AppRippleWidget(
            radius: AppSize.s12,
            onTap: () {
              ref.read(resetPasswordControllerProvider.notifier).changeVisibilityRePassword();
            },
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: obscureText ? ColorManager.greyBorder : ColorManager.colorPrimary,
            ),
          ),
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
