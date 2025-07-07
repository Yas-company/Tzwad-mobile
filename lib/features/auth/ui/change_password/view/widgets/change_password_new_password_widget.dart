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
import 'package:tzwad_mobile/features/auth/ui/change_password/hooks/change_password_new_password_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/providers/change_password_controller_provider.dart';

class ChangePasswordNewPasswordWidget extends HookConsumerWidget {
  const ChangePasswordNewPasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      changePasswordControllerProvider.select(
        (value) => value.newPasswordValidationMessage,
      ),
    );
    final obscureText = ref.watch(
      changePasswordControllerProvider.select(
        (value) => value.obscureTextNewPassword,
      ),
    );
    final controller = useChangePasswordNewPasswordController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strNewPassword.tr(context),
          style: StyleManager.getRegularStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: controller,
          hintText: AppStrings.strHintPassword.tr(context),
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          obscureText: obscureText,
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: ColorManager.greyHint,
            size: 25,
          ),
          suffixIcon: AppRippleWidget(
            radius: AppSize.s12,
            onTap: () {
              ref.read(changePasswordControllerProvider.notifier).changeVisibilityNewPassword();
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
