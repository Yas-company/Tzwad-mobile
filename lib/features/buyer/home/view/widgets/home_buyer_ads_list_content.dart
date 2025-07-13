import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/ads/models/ads_model.dart';

import 'item_home_ads.dart';

class HomeBuyerAdsListContent extends StatelessWidget {
  const HomeBuyerAdsListContent({
    super.key,
    required this.ads,
    this.isLoading = false,
  });

  final List<AdsModel> ads;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'العروض المميزة',
                style: StyleManager.getSemiBoldStyle(
                  color: ColorManager.colorBlack1,
                  fontSize: FontSize.s16,
                ),
              ),
              AppRippleWidget(
                onTap: () => _onPressedMoreButton(context),
                child: Row(
                  children: [
                    Text(
                      'المزيد',
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.colorBlack2,
                        fontSize: FontSize.s12,
                      ),
                    ).marginOnly(
                      end: AppPadding.p2,
                    ),
                    Transform.rotate(
                      angle: 3.14,
                      child: const Icon(
                        Icons.arrow_back,
                        size: AppSize.s16,
                        color: ColorManager.colorBlack2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ).marginOnly(
            start: AppPadding.p16,
            end: AppPadding.p16,
            bottom: AppPadding.p12,
          ),
          SizedBox(
            height: AppSize.s140,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) => ItemHomeAds(
                ads: ads[index],
              ),
              itemCount: ads.length,
              viewportFraction: 0.85,
              scale: 0.92,
              autoplay: true,
            ),
          ),
        ],
      ),
    );
  }

  _onPressedMoreButton(BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
    // Navigate to more ads page
  }
}
