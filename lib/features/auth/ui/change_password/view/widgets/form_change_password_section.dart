import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/controller/change_password_state.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/providers/change_password_controller_provider.dart';

import 'change_password_current_password_widget.dart';
import 'change_password_new_password_widget.dart';
import 'change_password_re_password_widget.dart';

class FormChangePasswordSection extends StatelessWidget {
  const FormChangePasswordSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ChangePasswordCurrentPasswordWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const ChangePasswordNewPasswordWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const ChangePasswordRePasswordWidget().marginOnly(
          bottom: AppPadding.p16,
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              changePasswordControllerProvider,
              (previous, next) => submitChangePasswordListener(context, previous, next),
            );
            final isLoading = ref.watch(
              changePasswordControllerProvider.select(
                (value) => value.submitChangePasswordDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: 'Change Password',
              onPressed: () => _onPressedChangePasswordButton(ref),
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  _onPressedChangePasswordButton(WidgetRef ref) {
    ref.read(changePasswordControllerProvider.notifier).changePassword();
  }

  void submitChangePasswordListener(BuildContext context, ChangePasswordState? previous, ChangePasswordState next) {
    if (previous?.submitChangePasswordDataState != next.submitChangePasswordDataState) {
      if (next.submitChangePasswordDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitChangePasswordDataState == DataState.success) {
        context.pop();
        context.showMessage(
          message: 'Password changed successfully',
          messageType: MessageType.success,
        );
      }
    }
  }
}
