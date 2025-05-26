import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'home_ads_section.dart';
import 'home_categories_section.dart';
import 'home_products_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppTextFieldWidget(
            hintText: 'Search for products, brands and categories',
            maxLines: 1,
            enabled: false,
            onTap: () => _onPressedSearchTextFiled(context),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_right_outlined,
            ),
          ).marginAll(
            AppPadding.p16,
          ),
          const HomeAdsSection().marginOnly(
            bottom: AppPadding.p16,
          ),
          const HomeProductsSection().marginOnly(
            bottom: AppPadding.p16,
          ),
          const HomeCategoriesSection().marginOnly(
            bottom: AppPadding.p32,
          ),
          // const HomeAdsSection().marginOnly(
          //   bottom: AppPadding.p32,
          // ),
        ],
      ),
    );
  }

  _onPressedSearchTextFiled(BuildContext context) {
    // ref.read(navBarControllerProvider.notifier).changeIndex(index);
    // 'Search for products, brands and categories'.log();
    // context.goNamed(AppRoutes.searchRoute);
  }
}
