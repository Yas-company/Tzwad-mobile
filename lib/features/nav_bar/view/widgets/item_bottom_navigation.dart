import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class ItemBottomNavigation extends StatelessWidget {
  const ItemBottomNavigation({
    super.key,
    required this.title,
    required this.assetName,
    required this.onTap,
    required this.isSelected,
  });

  final String title;
  final String assetName;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AppRippleWidget(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isSelected ? ColorManager.colorPrimary : Colors.transparent,
              width: AppSize.s2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppSvgPictureWidget(
                assetName: assetName,
                width: AppSize.s24,
                height: AppSize.s24,
                color: isSelected ? ColorManager.colorPrimary : ColorManager.colorBlack2,
              ).marginOnly(
                bottom: AppPadding.p4,
              ),
              Text(
                title,
                style: StyleManager.getMediumStyle(
                  color: isSelected ? ColorManager.colorPrimary : ColorManager.colorBlack2,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
