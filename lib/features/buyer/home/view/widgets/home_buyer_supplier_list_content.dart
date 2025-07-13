import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';

import 'item_home_ads.dart';

class HomeBuyerSupplierListContent extends StatelessWidget {
  const HomeBuyerSupplierListContent({
    super.key,
    required this.items,
    this.isLoading = false,
  });

  final List<SupplierModel> items;
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
                'الموردين',
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
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              itemBuilder: (BuildContext context, int index) => Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSize.s8),
                  color: ColorManager.colorWhite4,
                ),
                // child: Image.network(
                //   items[index].image ?? '',
                //   fit: BoxFit.cover,
                // ),
              ),
              separatorBuilder: (context, index) => const Gap(AppPadding.p12),
              itemCount: items.length,
            ),
          ),
        ],
      ),
    );
  }

  _onPressedMoreButton(BuildContext context) {
    context.pushNamed(AppRoutes.suppliersRoute);
  }
}
