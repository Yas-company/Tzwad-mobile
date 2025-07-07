import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/hooks/register_buyer_phone_number_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

class RegisterPhoneNumberWidget extends HookConsumerWidget {
  const RegisterPhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      registerBuyerControllerProvider.select(
        (value) => value.phoneNumberValidationMessage,
      ),
    );
    final phoneNumberController = useRegisterBuyerPhoneNumberController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strPhoneNumber.tr(context),
          style: StyleManager.getRegularStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: phoneNumberController,
          hintText: AppStrings.strHintPhoneNumber.tr(context),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          maxLength: 10,
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
