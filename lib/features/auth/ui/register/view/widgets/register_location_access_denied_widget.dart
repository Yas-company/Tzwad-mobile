import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

class RegisterLocationAccessDeniedWidget extends StatelessWidget {
  const RegisterLocationAccessDeniedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppSvgPictureWidget(
            assetName: AssetsManager.imgAccessDenied,
            width: AppSize.s200,
            height: AppSize.s200,
          ).marginOnly(
            bottom: AppPadding.p16,
          ),
          Text(
            'Location Permission is required to register, please allow it.',
            textAlign: TextAlign.center,
            style: StyleManager.getRegularStyle(
              color: ColorManager.greyHint,
            ),
          ).marginOnly(
            bottom: AppPadding.p16,
          ),
          Consumer(
            builder: (context, ref, child) {
              return AppButtonWidget(
                label: 'Enable',
                onPressed: () => _onPressedEnableLocationButton(ref),
                buttonType: ButtonType.outline,
              );
            },
          ),
        ],
      ),
    );
  }

  _onPressedEnableLocationButton(WidgetRef ref) {
    ref.read(registerControllerProvider.notifier).getLocation();
  }
}
