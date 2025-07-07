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
import 'package:tzwad_mobile/features/auth/ui/register_buyer/hooks/register_buyer_address_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/hooks/register_buyer_city_hook.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

class RegisterBuyerCityWidget extends HookConsumerWidget {
  const RegisterBuyerCityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorText = ref.watch(
      registerBuyerControllerProvider.select(
        (value) => value.cityValidationMessage,
      ),
    );
    final controller = useRegisterBuyerCityController(
      ref: ref,
      initialText: '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'المدينة',
          style: StyleManager.getMediumStyle(
            color: ColorManager.greytitle,
            fontSize: FontSize.s16,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        AppTextFieldWidget(
          controller: controller,
          hintText: 'أدخل المدينة',
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          errorText: errorText,
          helperText: ' ',
        )
      ],
    );
  }
}
