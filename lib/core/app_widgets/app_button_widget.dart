import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

enum ButtonSize { small, large }

enum ButtonType { solid, outline }

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.buttonType = ButtonType.solid,
    this.buttonSize = ButtonSize.large,
    this.assetsIcon,
    this.isExpanded = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.height,
  });

  final String label;
  final VoidCallback onPressed;
  final ButtonType buttonType;
  final ButtonSize buttonSize;
  final String? assetsIcon;
  final bool isExpanded;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final double mHeight = height ?? (buttonSize == ButtonSize.large ? AppSize.s50 : AppSize.s40);
    final bool isSolid = buttonType == ButtonType.solid;
    final Color mBackgroundColor = backgroundColor ?? (isSolid ? ColorManager.colorPrimary : ColorManager.colorPureWhite);
    final Color mTextColor = textColor ?? (isSolid ? ColorManager.colorPureWhite : ColorManager.colorPrimary);
    final Color mBorderColor = borderColor ?? ColorManager.colorPrimary;

    return SizedBox(
      height: mHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppSize.s10),
          child: Ink(
            decoration: BoxDecoration(
              // gradient: isSolid
              //     ? const LinearGradient(
              //         colors: [
              //           ColorManager.colorPrimary,
              //           ColorManager.colorPrimary,
              //         ],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       )
              //     : null,
              color: mBackgroundColor,
              borderRadius: BorderRadius.circular(AppSize.s10),
              border: buttonType == ButtonType.outline
                  ? Border.all(
                      color: mBorderColor,
                    )
                  : null,
            ),
            child: Row(
              mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // if (assetsIcon != null) ...{
                //   AppSvgPictureWidget(
                //     assetName: assetsIcon!,
                //     width: AppSize.s20,
                //     height: AppSize.s20,
                //   ).marginOnly(
                //     end: AppPadding.p4,
                //   ),
                // },
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: StyleManager.getSemiBoldStyle(
                      color: mTextColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ).marginSymmetric(
              horizontal: isExpanded ? 0 : AppPadding.p8,
            ),
          ),
        ),
      ),
    );
  }
}
