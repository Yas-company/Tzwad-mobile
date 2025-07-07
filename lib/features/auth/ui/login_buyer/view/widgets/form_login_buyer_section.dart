import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/controller/login_buyer_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/providers/login_buyer_controller_provider.dart';

import 'login_password_widget.dart';
import 'login_phone_number_widget.dart';
import 'remember_forget_section.dart';

class FormLoginBuyerSection extends StatelessWidget {
  const FormLoginBuyerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              loginBuyerControllerProvider,
              (previous, next) => submitLoginListener(context, previous, next),
            );
            final isLoading = ref.watch(
              loginBuyerControllerProvider.select(
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
    ref.read(loginBuyerControllerProvider.notifier).login();
  }

  void submitLoginListener(BuildContext context, LoginBuyerState? previous, LoginBuyerState next) {
    if (previous?.submitLoginDataState != next.submitLoginDataState) {
      if (next.submitLoginDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitLoginDataState == DataState.success) {
        context.pushReplacementNamed(AppRoutes.homeBuyerRoute);
      }
    }
  }
}
