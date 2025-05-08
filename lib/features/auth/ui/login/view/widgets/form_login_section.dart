import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login/controller/login_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login/providers/login_controller_provider.dart';

import 'login_password_widget.dart';
import 'login_phone_number_widget.dart';
import 'remember_forget_section.dart';

class FormLoginSection extends StatelessWidget {
  const FormLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strWelcomeBack.tr(context),
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.colorTitleTexts,
            fontSize: FontSize.s18,
          ),
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        const LoginPhoneNumberWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const LoginPasswordWidget(),
        const RememberForgetSection().marginOnly(
          bottom: AppPadding.p20,
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              loginControllerProvider,
              (previous, next) => submitLoginListener(context, previous, next),
            );
            final isLoading = ref.watch(
              loginControllerProvider.select(
                (value) => value.submitLoginDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: AppStrings.strLogin.tr(context),
              onPressed: () => _onPressedLoginButton(ref),
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  _onPressedLoginButton(WidgetRef ref) {
    ref.read(loginControllerProvider.notifier).login();
  }

  void submitLoginListener(BuildContext context, LoginState? previous, LoginState next) {
    if (previous?.submitLoginDataState != next.submitLoginDataState) {
      'State: ${next.submitLoginDataState}'.log();
      if (next.submitLoginDataState == DataState.failure) {
        'Error: ${next.failure?.message ?? ''}'.log();
      } else if (next.submitLoginDataState == DataState.success) {
        context.pushReplacementNamed(AppRoutes.navBarRoute);
      }
    }
  }
}
