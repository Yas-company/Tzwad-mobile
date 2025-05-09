import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: child,
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   type: BottomNavigationBarType.fixed,
      //   // backgroundColor: ColorManager.blackColor,
      //   selectedItemColor: ColorManager.blackColor,
      //   unselectedItemColor: ColorManager.blackColor,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   elevation: 0,
      //   onTap: (index) {
      //     switch (index) {
      //       case 0:
      //         context.go(AppRoutes.homeRoute);
      //       case 1:
      //         context.go(AppRoutes.searchRoute);
      //       case 2:
      //         context.go(AppRoutes.cartRoute);
      //       case 3:
      //         context.go(AppRoutes.favoriteRoute);
      //       case 4:
      //         context.go(AppRoutes.settingsRoute);
      //     }
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.card_travel_sharp),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
}
