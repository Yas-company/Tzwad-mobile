import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'home_buyer_cart_button.dart';

class HomeBuyerAppBarWidget extends ConsumerWidget {
  const HomeBuyerAppBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      // height: AppSize.s220,
      padding: const EdgeInsets.all(AppPadding.p16),
      decoration: const BoxDecoration(
        color: ColorManager.colorPrimary,
        image: DecorationImage(
          alignment: AlignmentDirectional.topStart,
          image: AssetImage(AssetsManager.imgTopographic),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الموقع',
                        style: StyleManager.getRegularStyle(
                          color: ColorManager.colorWhite3,
                        ),
                      ),
                      Row(
                        children: [
                          const AppSvgPictureWidget(
                            assetName: AssetsManager.icLocation,
                          ).marginOnly(
                            end: AppPadding.p8,
                          ),
                          Text(
                            'الرياض - حي الفردوس',
                            style: StyleManager.getMediumStyle(
                              color: ColorManager.colorWhite1,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                const HomeBuyerCartButton(),
              ],
            ).marginOnly(
              bottom: AppPadding.p16,
              top: AppPadding.p16,
            ),
            const AppTextFieldWidget(
              fillColor: ColorManager.colorWhite1,
              prefixIcon: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: Center(
                  child: AppSvgPictureWidget(
                    assetName: AssetsManager.icSearch,
                  ),
                ),
              ),
              hintText: 'بحث . . .',
            )
          ],
        ),
      ),
    );
  }
}
