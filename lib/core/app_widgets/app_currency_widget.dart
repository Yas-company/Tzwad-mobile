import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class AppCurrencyWidget extends StatelessWidget {
  const AppCurrencyWidget({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppSvgPictureWidget(
      assetName: AssetsManager.icCurrency,
      width: AppSize.s18,
      height: AppSize.s18,
      color: color ?? ColorManager.colorBlack1,
    );
  }
}
