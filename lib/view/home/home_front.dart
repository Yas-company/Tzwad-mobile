import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../service/cart_data_service.dart';
import '../../service/favorite_data_service.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/product_card_data_service.dart';
import '../../view/cart/cart_view.dart';
import '../../view/favorite/favorite.dart';
import '../../view/home/home.dart';
import '../../view/search/search.dart';
import '../../view/settings/setting.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import '../../service/search_result_data_service.dart';
import '../search/filter_bottom_sheeet.dart';

class HomeFront extends StatelessWidget {
  static const String routeName = 'HomeFront/';

  HomeFront({Key? key}) : super(key: key);

  final ConstantColors cc = ConstantColors();
  int _navigationIndex = 0;

  PreferredSizeWidget? manageAppBar(
    BuildContext context,
  ) {
    final values = Provider.of<SearchResultDataService>(context, listen: false);
    if (_navigationIndex == 0) {
      return helloAppBar(context);
    }
    if (_navigationIndex == 1) {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        leading: Consumer<SearchResultDataService>(
            builder: (context, srService, child) {
          return IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                showModalBottomSheet(
                  context: context,
                  builder: (context) => SingleChildScrollView(
                    // controller: ModalScrollController.of(context),
                    child: const FilterBottomSheet(),
                  ),
                );
              },
              icon: SvgPicture.asset(
                'assets/images/icons/filter_setting.svg',
                color: srService.finterOn ? cc.primaryColor : null,
              ));
        }),
        actions: [
          PopupMenuButton<String>(
              icon: Icon(
                Icons.sort,
                color: cc.blackColor,
              ),
              onSelected: (value) {
                FocusScope.of(context).unfocus();
                print(value);
                Provider.of<SearchResultDataService>(context, listen: false)
                  ..setSortBy(value)
                  ..resetSerch()
                  ..fetchProductsBy();
                // Provider.of<SearchResultDataService>(context, listen: false)
                //     .fetchProductsBy(pageNo: '1');
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text(
                        asProvider.getString('Popularity'),
                        style: TextStyle(
                            color: Provider.of<SearchResultDataService>(context,
                                            listen: false)
                                        .sortBy ==
                                    'popularity'
                                ? cc.primaryColor
                                : cc.blackColor),
                      ),
                      value: values.sortOption[0],
                    ),
                    PopupMenuItem(
                      child: Text(
                        asProvider.getString('Latest'),
                        style: TextStyle(
                            color: Provider.of<SearchResultDataService>(context,
                                            listen: false)
                                        .sortBy ==
                                    'latest'
                                ? cc.primaryColor
                                : cc.blackColor),
                      ),
                      value: values.sortOption[1],
                    ),
                    PopupMenuItem(
                      child: Text(
                        asProvider.getString('Lower price'),
                        style: TextStyle(
                            color: Provider.of<SearchResultDataService>(context,
                                            listen: false)
                                        .sortBy ==
                                    'price_low'
                                ? cc.primaryColor
                                : cc.blackColor),
                      ),
                      value: values.sortOption[2],
                    ),
                    PopupMenuItem(
                      child: Text(
                        asProvider.getString('Higher price'),
                        style: TextStyle(
                            color: Provider.of<SearchResultDataService>(context,
                                            listen: false)
                                        .sortBy ==
                                    'price_high'
                                ? cc.primaryColor
                                : cc.blackColor),
                      ),
                      value: values.sortOption[3],
                    ),
                  ]),
          const SizedBox(
            width: 17,
          )
        ],
      );
    }
    if (_navigationIndex == 2) {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          asProvider.getString('My cart'),
          style: TextStyle(
              color: cc.blackColor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
      );
    }
    if (_navigationIndex == 3) {
      return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: 0,
        centerTitle: true,
        title: Text(
          asProvider.getString('My favorite'),
          style: TextStyle(
              color: cc.blackColor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
      );
    }
    return null;
  }

  Widget navigationWidget = Home();
  @override
  Widget build(BuildContext context) {
    searchHelper(context);

    return Consumer<NavigationBarHelperService>(
        builder: (context, nData, child) {
      return Scaffold(
        appBar: manageAppBar(context),
        body: navigationWidget,
        bottomNavigationBar: BottomNavigationBar(
            onTap: (v) {
              ontapIndexManager(context, v, nData);
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
            items: items),
      );
    });
  }

  productsGetter(BuildContext context) {
    Provider.of<ProductCardDataService>(context, listen: false)
        .fetchFeaturedProductCardData();
    Provider.of<ProductCardDataService>(context, listen: false)
        .fetchCapmaignCardProductData();
  }

  ontapIndexManager(
    BuildContext context,
    int v,
    NavigationBarHelperService nData,
  ) {
    nData.setNavigationIndex(v);
    if (nData.navigationIndex == 0) {
      FocusScope.of(context).unfocus();
      nData.setSearchText('');
      navigationWidget = Home();

      return;
    }
    if (nData.navigationIndex == 1) {
      FocusScope.of(context).unfocus();
      Provider.of<SearchResultDataService>(context, listen: false).resetSerch();
      Provider.of<SearchResultDataService>(context, listen: false)
          .resetSerchFilters();
      Provider.of<SearchResultDataService>(context, listen: false)
          .setSearchText('');
      nData.setSearchText('');
      Provider.of<SearchResultDataService>(context, listen: false)
          .fetchProductsBy(pageNo: '1');
      navigationWidget = SearchView();
      return;
    }
    if (nData.navigationIndex == 2) {
      navigationWidget = CartView();
      return;
    }
    if (nData.navigationIndex == 3) {
      navigationWidget = FavoriteView();
      return;
    }
    if (nData.navigationIndex == 4) {
      navigationWidget = SettingView();
      return;
    }
  }

  searchHelper(BuildContext context) {
    _navigationIndex =
        Provider.of<NavigationBarHelperService>(context).navigationIndex;
    if (_navigationIndex == 0) {
      productsGetter(context);
      navigationWidget = Home();
    }
    if (_navigationIndex == 1) {
      navigationWidget = SearchView();
    }
    if (_navigationIndex == 2) {
      navigationWidget = CartView();
    }
    if (_navigationIndex == 3) {
      navigationWidget = FavoriteView();
    }
    if (_navigationIndex == 4) {
      navigationWidget = SettingView();
    }
  }

  List<BottomNavigationBarItem> get items => [
        BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              'assets/images/icons/home_selected.svg',
              height: 27,
              color: cc.primaryColor,
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
