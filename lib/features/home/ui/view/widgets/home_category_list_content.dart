import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'item_home_category.dart';

class HomeCategoryListContent extends StatelessWidget {
  const HomeCategoryListContent({
    super.key,
    required this.categories,
    this.isLoading = false,
  });

  final List<CategoryModel> categories;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Categories',
                style: StyleManager.getSemiBoldStyle(
                  color: ColorManager.greyFour,
                  fontSize: FontSize.s18,
                ),
              ),
              AppRippleWidget(
                onTap: () => _onPressedSeeAllButton(context),
                child: Text(
                  'See All',
                  style: StyleManager.getSemiBoldStyle(
                    color: ColorManager.colorPrimary,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ],
          ).marginOnly(
            start: AppPadding.p16,
            end: AppPadding.p16,
            bottom: AppPadding.p16,
          ),
          SizedBox(
            height: AppSize.s60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p10,
              ),
              itemBuilder: (context, index) => ItemHomeCategory(
                category: categories[index],
              ),
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }

  _onPressedSeeAllButton(BuildContext context) {
    // context.pushNamed(AppRoutes.pro);
  }
}
