import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'home_ads_section.dart';
import 'home_buyer_app_bar_widget.dart';
import 'home_buyer_suppliers_section.dart';

class HomeBuyerViewBody extends StatelessWidget {
  const HomeBuyerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverAppBar(
          // leading: IconButton(
          //   onPressed: () => _onPressedSkipButton(context),
          //   icon: const Icon(Icons.close),
          // ),
          automaticallyImplyLeading: false,
          pinned: true,
          expandedHeight: AppSize.s175,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: HomeBuyerAppBarWidget(),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Gap(
                AppPadding.p20,
              ),
              HomeAdsSection(),
              Gap(
                AppPadding.p16,
              ),
              HomeBuyerSuppliersSection(),

            ],
          ),
        )
      ],
    );
  }

  _onPressedSearchTextFiled(BuildContext context) {
    // ref.read(navBarControllerProvider.notifier).changeIndex(index);
    // 'Search for products, brands and categories'.log();
    // context.goNamed(AppRoutes.searchRoute);
  }
}
