import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';

class HomeBuyerCartButton extends StatelessWidget {
  const HomeBuyerCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppPadding.p2),
      width: AppSize.s44,
      height: AppSize.s44,
      decoration: BoxDecoration(
        color: ColorManager.colorWhite1,
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      alignment: Alignment.center,
      child: AppRippleWidget(
          radius: AppSize.s8,
          onTap: () => _onPressedCartButton(context),
          child: const AppSvgPictureWidget(
            assetName: AssetsManager.icCart,
            color: ColorManager.colorBlack1,
          )),
    );
  }

  _onPressedCartButton(BuildContext context) {
    context.pushNamed(AppRoutes.cartRoute);
  }
}
