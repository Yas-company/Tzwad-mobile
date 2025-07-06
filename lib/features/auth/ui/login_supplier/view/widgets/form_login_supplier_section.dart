import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/controller/login_supplier_state.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/providers/login_supplier_controller_provider.dart';

import 'login_supplier_password_widget.dart';
import 'login_supplier_phone_number_widget.dart';

class FormLoginSupplierSection extends StatelessWidget {
  const FormLoginSupplierSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginSupplierPhoneNumberWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const LoginSupplierPasswordWidget(),
        // const RememberForgetSection().marginOnly(
        //   bottom: AppPadding.p20,
        // ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              loginSupplierControllerProvider,
              (previous, next) => submitLoginListener(context, previous, next),
            );
            final isLoading = ref.watch(
              loginSupplierControllerProvider.select(
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
    ref.read(loginSupplierControllerProvider.notifier).login();
  }

  void submitLoginListener(BuildContext context, LoginSupplierState? previous, LoginSupplierState next) {
    if (previous?.submitLoginDataState != next.submitLoginDataState) {
      if (next.submitLoginDataState == DataState.failure) {
        context.showMessage(
          message: next.failure?.message ?? '',
        );
      } else if (next.submitLoginDataState == DataState.success) {
        // context.pushReplacementNamed(AppRoutes.homeRoute);
      }
    }
  }
}
