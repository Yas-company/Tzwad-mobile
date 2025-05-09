import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/controller/reset_password_state.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/providers/reset_password_controller_provider.dart';

import 'reset_password_password_widget.dart';
import 'reset_password_re_password_widget.dart';

class FormResetPasswordSection extends StatelessWidget {
  const FormResetPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResetPasswordPasswordWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const ResetPasswordRePasswordWidget().marginOnly(
          bottom: AppPadding.p16,
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              resetPasswordControllerProvider,
              (previous, next) => submitResetPasswordListener(context, previous, next),
            );
            final isLoading = ref.watch(
              resetPasswordControllerProvider.select(
                (value) => value.submitResetPasswordDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: AppStrings.strResetPassword.tr(context),
              onPressed: () => _onPressedResetPasswordButton(ref),
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  _onPressedResetPasswordButton(WidgetRef ref) {
    final phoneNumber = appArgs(AppRoutes.otpRoute)['phoneNumber'];
    ref.read(resetPasswordControllerProvider.notifier).resetPassword(phoneNumber);
  }

  void submitResetPasswordListener(BuildContext context, ResetPasswordState? previous, ResetPasswordState next) {
    if (previous?.submitResetPasswordDataState != next.submitResetPasswordDataState) {
      'State: ${next.submitResetPasswordDataState}'.log();
      if (next.submitResetPasswordDataState == DataState.failure) {
        'Error: ${next.failure?.message ?? ''}'.log();
      } else if (next.submitResetPasswordDataState == DataState.success) {
        context.pushNamed(AppRoutes.homeRoute);
      }
    }
  }
}
