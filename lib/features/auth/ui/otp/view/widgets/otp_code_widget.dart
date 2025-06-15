import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/login/providers/login_controller_provider.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/hooks/otp_code_hook.dart';

class OtpCodeWidget extends HookConsumerWidget {
  const OtpCodeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      loginControllerProvider.select(
        (value) => value.phoneNumberValidationMessage,
      ),
    );
    final controller = useOtpCodeController(
      ref: ref,
      initialText: '',
    );
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        autofocus: true,
        controller: controller,
        length: 6,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: focusedPinTheme,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        errorText: errorText.isEmpty ? null : errorText,
        onCompleted: (otp) {},
      ),
    );
  }

  PinTheme get defaultPinTheme => PinTheme(
        width: 50,
        height: 50,
        textStyle: StyleManager.getMediumStyle(
          color: ColorManager.colorBlack1,
          fontSize: FontSize.s16,
        ),
        decoration: BoxDecoration(
          color: ColorManager.colorWhite3,
          borderRadius: BorderRadius.circular(AppSize.s8),
          border:
              Border.all(color: ColorManager.colorWhite3, width: AppSize.s1),
        ),
      );

  PinTheme get focusedPinTheme => PinTheme(
        width: 50,
        height: 50,
        textStyle: StyleManager.getMediumStyle(
          color: ColorManager.colorBlack1,
          fontSize: FontSize.s16,
        ),
        decoration: BoxDecoration(
          color: ColorManager.colorWhite3,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: ColorManager.colorWhite3, width: AppSize.s1),
        ),
      );
}
