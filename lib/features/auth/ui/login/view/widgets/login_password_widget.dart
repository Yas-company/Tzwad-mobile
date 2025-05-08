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
import 'package:tzwad_mobile/features/auth/ui/login/hooks/login_password_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/login/providers/login_controller_provider.dart';

class LoginPasswordWidget extends HookConsumerWidget {
  const LoginPasswordWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      loginControllerProvider.select(
        (value) => value.passwordValidationMessage,
      ),
    );
    final passwordController = useLoginPasswordController(
      ref: ref,
      initialText: '',
    );
    final obscureText = ref.watch(
      loginControllerProvider.select(
        (value) => value.obscureText,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strPassword.tr(context),
          style: StyleManager.getMediumStyle(
            color: ColorManager.greytitle,
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
          prefixIcon: const Icon(
            Icons.lock_outlined,
            color: ColorManager.greyHint,
            size: 25,
          ),
          suffixIcon: AppRippleWidget(
            radius: AppSize.s12,
            onTap: () {
              ref.read(loginControllerProvider.notifier).changeVisibilityPassword();
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
