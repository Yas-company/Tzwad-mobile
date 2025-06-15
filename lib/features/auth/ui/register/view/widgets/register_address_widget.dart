import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register/hooks/register_address_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

class RegisterAddressWidget extends HookConsumerWidget {
  const RegisterAddressWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      registerControllerProvider.select(
        (value) => value.addressValidationMessage,
      ),
    );
    final addressController = useRegisterAddressController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.strAddress.tr(context),
          style: StyleManager.getMediumStyle(
            color: ColorManager.greytitle,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: addressController,
          hintText: AppStrings.strHintAddress.tr(context),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
