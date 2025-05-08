import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register/hooks/register_name_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

class RegisterNameWidget extends HookConsumerWidget {
  const RegisterNameWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      registerControllerProvider.select(
        (value) => value.nameValidationMessage,
      ),
    );
    final phoneNumberController = useRegisterNameController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name',
          style: StyleManager.getMediumStyle(
            color: ColorManager.greytitle,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: phoneNumberController,
          hintText: 'Enter your name',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          prefixIcon: const Icon(
            Icons.perm_identity_rounded,
            color: ColorManager.greyHint,
            size: 25,
          ),
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
