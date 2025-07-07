import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/nav_bar/providers/nav_bar_controller_provider.dart';

import 'item_bottom_navigation.dart';

class BuyerBottomNavigation extends ConsumerWidget {
  const BuyerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(
      navBarControllerProvider.select(
        (value) => value.currentIndex,
      ),
    );

    // final countCart = ref.watch(
    //   navBarControllerProvider.select(
    //     (value) => value.countCart,
    //   ),
    // );
    return Container(
      decoration: const BoxDecoration(
        color: ColorManager.colorBackground,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ItemBottomNavigation(
                title: 'الرئيسية',
                assetName: AssetsManager.icTabHome,
                onTap: () => _onPressedItemBottomNavigation(ref, context, 0),
                isSelected: currentIndex == 0,
              ),
              ItemBottomNavigation(
                title: 'الطلبات',
                assetName: AssetsManager.icTabOrders,
                onTap: () => _onPressedItemBottomNavigation(ref, context, 1),
                isSelected: currentIndex == 1,
              ),
              ItemBottomNavigation(
                title: 'المفضلة',
                assetName: AssetsManager.icTabFavorites,
                onTap: () => _onPressedItemBottomNavigation(ref, context, 2),
                isSelected: currentIndex == 2,
              ),
              ItemBottomNavigation(
                title: 'المزيد',
                assetName: AssetsManager.icTabMore,
                onTap: () => _onPressedItemBottomNavigation(ref, context, 3),
                isSelected: currentIndex == 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedItemBottomNavigation(WidgetRef ref, BuildContext context, int index) {
    ref.read(navBarControllerProvider.notifier).changeIndex(index);
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.homeBuyerRoute);
      case 1:
        context.goNamed(AppRoutes.ordersBuyerRoute);
      case 2:
        context.goNamed(AppRoutes.favoriteProductsRoute);
      case 3:
        context.goNamed(AppRoutes.moreBuyerRoute);
    }
  }
}
