import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/hooks/register_buyer_street_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

class RegisterBuyerStreetWidget extends HookConsumerWidget {
  const RegisterBuyerStreetWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      registerBuyerControllerProvider.select(
        (value) => value.streetValidationMessage,
      ),
    );
    final controller = useRegisterBuyerStreetController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'الشارع',
          style: StyleManager.getRegularStyle(
            color: ColorManager.colorBlack1,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: controller,
          hintText: 'أدخل الشارع',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
