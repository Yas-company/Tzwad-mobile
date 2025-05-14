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
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/controller/forget_password_state.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/providers/forget_password_controller_provider.dart';

import 'forget_password_phone_number_widget.dart';

class FormForgetPasswordSection extends StatelessWidget {
  const FormForgetPasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ForgetPasswordPhoneNumberWidget().marginOnly(
          bottom: AppPadding.p16,
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              forgetPasswordControllerProvider,
              (previous, next) => submitForgetPasswordListener(context, previous, next),
            );
            final isLoading = ref.watch(
              forgetPasswordControllerProvider.select(
                (value) => value.submitForgetPasswordDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: AppStrings.strForgetPassword.tr(context),
              onPressed: () => _onPressedForgetPasswordButton(ref),
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  _onPressedForgetPasswordButton(WidgetRef ref) {
    ref.read(forgetPasswordControllerProvider.notifier).forgetPassword();
  }

  void submitForgetPasswordListener(BuildContext context, ForgetPasswordState? previous, ForgetPasswordState next) {
    if (previous?.submitForgetPasswordDataState != next.submitForgetPasswordDataState) {
      if (next.submitForgetPasswordDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitForgetPasswordDataState == DataState.success) {
        context.pushNamed(
          AppRoutes.otpRoute,
          extra: {
            'phoneNumber': next.phoneNumber,
            'otpFlowType': OtpFlowType.forgetPassword,
          },
        );
      }
    }
  }
}
