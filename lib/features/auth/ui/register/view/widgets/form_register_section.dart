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
import 'package:tzwad_mobile/features/auth/ui/register/controller/register_state.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

import 'accept_terms_conditions_section.dart';
import 'register_address_widget.dart';
import 'register_name_widget.dart';
import 'register_password_widget.dart';
import 'register_phone_number_widget.dart';

class FormRegisterSection extends StatelessWidget {
  const FormRegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register to join us',
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.colorTitleTexts,
            fontSize: FontSize.s18,
          ),
        ).marginOnly(
          bottom: AppPadding.p16,
        ),
        const RegisterNameWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const RegisterPhoneNumberWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const RegisterAddressWidget().marginOnly(
          bottom: AppPadding.p4,
        ),
        const RegisterPasswordWidget(),
        const AcceptTermsConditionsSection().marginOnly(
          bottom: AppPadding.p20,
        ),
        Consumer(
          builder: (context, ref, child) {
            ref.listen(
              registerControllerProvider,
              (previous, next) => submitRegisterListener(context, previous, next),
            );
            final isLoading = ref.watch(
              registerControllerProvider.select(
                (value) => value.submitRegisterDataState == DataState.loading,
              ),
            );
            return AppButtonWidget(
              label: AppStrings.strRegister.tr(context),
              onPressed: () => _onPressedRegisterButton(ref),
              isLoading: isLoading,
            );
          },
        ),
      ],
    );
  }

  _onPressedRegisterButton(WidgetRef ref) {
    ref.read(registerControllerProvider.notifier).register();
  }

  void submitRegisterListener(BuildContext context, RegisterState? previous, RegisterState next) {
    if (previous?.submitRegisterDataState != next.submitRegisterDataState) {
      'State: ${next.submitRegisterDataState}'.log();
      if (next.submitRegisterDataState == DataState.failure) {
        'Error: ${next.failure?.message ?? ''}'.log();
      } else if (next.submitRegisterDataState == DataState.success) {
        context.pushNamed(AppRoutes.otpRoute);
      }
    }
  }
}
