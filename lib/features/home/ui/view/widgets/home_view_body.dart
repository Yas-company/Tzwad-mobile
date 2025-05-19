import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'home_ads_section.dart';
import 'home_categories_section.dart';
import 'home_products_section.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          Gap(
            20,
          ),
          HomeAdsSection(),
          Gap(
            20,
          ),
          HomeProductsSection(),
          Gap(
            20,
          ),
          HomeCategoriesSection(),
          Gap(
            20,
          ),
          HomeAdsSection(),
        ],
      ),
    );
  }
}
