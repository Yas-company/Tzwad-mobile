import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';

class AppButtonChangeLanguageWidget extends StatelessWidget {
  const AppButtonChangeLanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _onPressedChangeLanguageButton(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'English',
            style: StyleManager.getRegularStyle(
              color: ColorManager.colorBlack1,
            ).copyWith(
              decoration: TextDecoration.underline,
            ),
          ).marginOnly(
            end: AppPadding.p2,
          ),
          const Icon(
            Icons.language,
            color: ColorManager.colorBlack1,
          ),
        ],
      ),
    );
  }

  _onPressedChangeLanguageButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }
}
