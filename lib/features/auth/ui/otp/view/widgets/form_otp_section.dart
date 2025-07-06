import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/controller/otp_state.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/providers/otp_controller_provider.dart';

import 'otp_code_widget.dart';

class FormOtpSection extends StatelessWidget {
  const FormOtpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Otp Field
        const OtpCodeWidget().marginOnly(
          bottom: AppPadding.p20,
        ),

        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              otpControllerProvider,
              (previous, next) => submitVerifyOtpListener(context, previous, next),
            );
            final isLoading = ref.watch(
              otpControllerProvider.select(
                (value) => value.submitVerifyOtpDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: AppStrings.strVerify.tr(context),
              onPressed: () => _onPressedVerifyButton(ref),
              isLoading: isLoading,
            );
          },
        ),

        // ResendCode(interactor: initAutoFill)
      ],
    );
  }

  _onPressedVerifyButton(WidgetRef ref) {
    final phoneNumber = appArgs['phoneNumber'];
    final otpFlowType = appArgs['otpFlowType'] as OtpFlowType;
    ref.read(otpControllerProvider.notifier).verifyOtp(phoneNumber, otpFlowType);
  }

  void submitVerifyOtpListener(BuildContext context, OtpState? previous, OtpState next) {
    final otpFlowType = appArgs['otpFlowType'] as OtpFlowType;
    if (previous?.submitVerifyOtpDataState != next.submitVerifyOtpDataState) {
      if (next.submitVerifyOtpDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitVerifyOtpDataState == DataState.success) {
        otpFlowType == OtpFlowType.register
            ? context.goNamed(AppRoutes.homeBuyerRoute)
            : context.pushNamed(
                AppRoutes.resetPasswordRoute,
                extra: {
                  'phoneNumber': appArgs['phoneNumber'],
                },
              );
      }
    }
  }
}
