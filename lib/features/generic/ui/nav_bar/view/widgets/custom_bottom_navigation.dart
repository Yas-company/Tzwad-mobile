import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_badge_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/generic/ui/nav_bar/providers/nav_bar_controller_provider.dart';

class CustomBottomNavigation extends ConsumerWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(
      navBarControllerProvider.select(
        (value) => value.currentIndex,
      ),
    );

    final countCart = ref.watch(
      navBarControllerProvider.select(
        (value) => value.countCart,
      ),
    );
    return BottomNavigationBar(
      currentIndex: currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
      onTap: (index) => _onPressedItemBottomNavigation(ref, context, index),
      items: [
        const BottomNavigationBarItem(
          icon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabHomeUnSelected,
          ),
          activeIcon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabHomeSelected,
          ),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabSearchUnSelected,
          ),
          activeIcon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabSearchSelected,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: AppBadgeWidget(
            label: '$countCart',
            isBadgeVisible: countCart != 0,
            child: const AppSvgPictureWidget(
              assetName: AssetsManager.icTabCartUnSelected,
            ),
          ),
          activeIcon: const AppSvgPictureWidget(
            assetName: AssetsManager.icTabCartSelected,
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(
          icon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabFavoriteUnSelected,
          ),
          activeIcon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabFavoriteSelected,
          ),
          label: 'Favorites',
        ),
        const BottomNavigationBarItem(
          icon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabSettingUnSelected,
          ),
          activeIcon: AppSvgPictureWidget(
            assetName: AssetsManager.icTabSettingSelected,
          ),
          label: 'Settings',
        ),
      ],
    );
  }

  _onPressedItemBottomNavigation(WidgetRef ref, BuildContext context, int index) {
    ref.read(navBarControllerProvider.notifier).changeIndex(index);
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.homeRoute);
      case 1:
        context.goNamed(AppRoutes.searchRoute);
      case 2:
        context.goNamed(AppRoutes.cartRoute);
      case 3:
        context.goNamed(AppRoutes.favoriteProductsRoute);
      case 4:
        context.goNamed(AppRoutes.settingsRoute);
    }
  }
}
