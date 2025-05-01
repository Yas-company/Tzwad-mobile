import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

import '../../service/cart_data_service.dart';
import '../../service/favorite_data_service.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/search_result_data_service.dart';
import 'home_front.dart';

class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationBarHelperService>(
        builder: (context, nData, child) {
      return BottomNavigationBar(
          onTap: (v) {
            Provider.of<SearchResultDataService>(context, listen: false)
                .resetSerchFilters();
            nData.setNavigationIndex(v);
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeFront()),
                (Route<dynamic> route) => false);
            return;
          },
          // fixedColor: cc.blackColor,

          type: BottomNavigationBarType.fixed,
          backgroundColor: cc.blackColor,
          selectedItemColor: cc.blackColor,
          unselectedItemColor: cc.blackColor,
          currentIndex: nData.navigationIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: items);
    });
  }

  List<BottomNavigationBarItem> get items => [
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              // 'assets/images/icons/home_selected.svg',
              'assets/images/icons/home.svg',
              height: 27,
              // color: cc.primaryColor,
              color: cc.greyHint,
            ),
            icon: SvgPicture.asset(
              'assets/images/icons/home.svg',
              height: 27,
              color: cc.greyHint,
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/search_fill.svg',
              height: 27,
              color: cc.primaryColor,
            ),
            icon: SvgPicture.asset(
              'assets/images/icons/search_navi.svg',
              height: 27,
              color: cc.greyHint,
            ),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/bag_fill.svg',
              height: 27,
              color: cc.primaryColor,
            ),
            icon:
                Consumer<CartDataService>(builder: (context, cartData, child) {
              return badge.Badge(
                showBadge: cartData.cartList!.isEmpty ? false : true,
                badgeContent: Text(
                  cartData.totalQuantity().toString(),
                  style: TextStyle(color: cc.pureWhite),
                ),
                child: SvgPicture.asset(
                  'assets/images/icons/bag.svg',
                  height: 27,
                  color: cc.greyHint,
                ),
              );
            }),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/heart_fill.svg',
              height: 27,
              color: cc.primaryColor,
            ),
            icon: Consumer<FavoriteDataService>(
                builder: (context, favoriteData, child) {
              return badge.Badge(
                showBadge: favoriteData.favoriteItems.isEmpty ? false : true,
                badgeContent: Text(
                  favoriteData.favoriteItems.length.toString(),
                  style: TextStyle(color: cc.pureWhite),
                ),
                child: SvgPicture.asset(
                  'assets/images/icons/heart.svg',
                  height: 27,
                  color: cc.greyHint,
                ),
              );
            }),
            label: ''),
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/setting_fill.svg',
              height: 27,
              color: cc.primaryColor,
            ),
            icon: SvgPicture.asset(
              'assets/images/icons/setting_unfill.svg',
              height: 27,
              color: cc.greyHint,
            ),
            label: ''),
      ];
}
