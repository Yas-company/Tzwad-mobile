import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';

class LoginAsSupplierWidget extends StatelessWidget {
  const LoginAsSupplierWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(AppPadding.p16),
        height: AppSize.s50,
        decoration: const BoxDecoration(
          color: ColorManager.colorSecondary,
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppSize.s8,
            ),
          ),
        ),
        child: AppRippleWidget(
          radius: AppSize.s8,
          onTap: () => _onPressedLoginAsSupplierButton(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
            child: Row(
              children: [
                const AppImageAssetWidget(
                  imagePath: AssetsManager.icStore,
                  width: AppSize.s24,
                  height: AppSize.s24,
                ).marginOnly(
                  end: AppPadding.p16,
                ),
                Expanded(
                  child: Text(
                    'تسجيل الدخول كتاجر',
                    style: StyleManager.getMediumStyle(
                      color: ColorManager.colorWhite1,
                      fontSize: FontSize.s16,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 3.14,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: ColorManager.colorWhite1,
                    size: AppSize.s24,
                  ),
                ).marginOnly(
                  start: AppPadding.p16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onPressedLoginAsSupplierButton(BuildContext context) {
    context.pushNamed(AppRoutes.loginSupplierRoute);
  }
}
