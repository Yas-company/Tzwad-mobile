import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Platform.isAndroid) ...{
            buttonSocialMedia(
              // label: 'حساب جوجل',
              assetName: AssetsManager.icGoogle,

            ),
            // const SizedBox(width: AppPadding.p20),
            // buttonSocialMedia(
            //   // label: 'تسجيل الدخول عبر حساب ابل',
            //   assetName: AssetsManager.icApple,
            // ),
          },
          if (Platform.isIOS) ...{
            buttonSocialMedia(
              // label: 'حساب جوجل',
              assetName: AssetsManager.icGoogle,
            ),
            const SizedBox(width: AppPadding.p12),
            buttonSocialMedia(
              // label: 'تسجيل الدخول عبر حساب ابل',
              assetName: AssetsManager.icApple,
            ),
          },
        ],
      ),
    );
  }

  Widget buttonSocialMedia({
    // required String label,
    required String assetName,
  }) {
    return SizedBox(
      width: AppSize.s80,
      height: AppSize.s80,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {

          },
          borderRadius: BorderRadius.circular(AppSize.s20),
          child: Ink(
            decoration: BoxDecoration(
              color: ColorManager.colorPureWhite,
              borderRadius: BorderRadius.circular(AppSize.s20),
              border: Border.all(
                color: ColorManager.colorWhite3,
              ),
            ),
            child: AppSvgPictureWidget(
              assetName: assetName,
              width: AppSize.s60,
              height: AppSize.s60,
            ).marginOnly(
              end: AppPadding.p4,
            ),


            /*
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSvgPictureWidget(
                assetName: assetName,
                width: AppSize.s60,
                height: AppSize.s60,
              ).marginOnly(
                end: AppPadding.p4,
              ),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: StyleManager.getMediumStyle(
                    color: ColorManager.colorWhite2,
                    fontSize: FontSize.s14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          */
          ).marginAll(AppPadding.p6),
        ),
      ),
    );
  }
}
