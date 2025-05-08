import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:tzwad_mobile/features/auth/ui/forget_password/hooks/forget_password_phone_number_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/providers/forget_password_controller_provider.dart';

class ForgetPasswordPhoneNumberWidget extends HookConsumerWidget {
  const ForgetPasswordPhoneNumberWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      forgetPasswordControllerProvider.select(
        (value) => value.phoneNumberValidationMessage,
      ),
    );
    final phoneNumberController = useForgetPasswordPhoneNumberController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strPhoneNumber.tr(context),
          style: StyleManager.getMediumStyle(
            color: ColorManager.greytitle,
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
          prefixIcon: AppRippleWidget(
            // radius: AppSize.s12,
            // onTap: () {
            //   '+966'.log();
            // },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    '+966',
                    style: StyleManager.getSemiBoldStyle(
                      color: ColorManager.greyHint,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          maxLength: 10,
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
