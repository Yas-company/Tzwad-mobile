import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../view/favorite/favorite_tile.dart';
import '../../view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

import '../../service/favorite_data_service.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return WillPopScope(
      onWillPop: () =>
          Provider.of<NavigationBarHelperService>(context, listen: false)
              .setNavigationIndex(0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Consumer<FavoriteDataService>(
            builder: (context, favoriteData, child) {
          return favoriteData.favoriteItems.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: screenHight / 2.5,
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset('assets/images/empty_favorite.png'),
                    ),
                    Center(
                      child: Text(
                        asProvider.getString('Add items to favorite'),
                        style: TextStyle(color: cc.greyHint),
                      ),
                    ),
                  ],
                )
              : ListView.separated(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: favoriteData.favoriteItems.values.length,
                  itemBuilder: (context, index) {
                    final element =
                        favoriteData.favoriteItems.values.toList()[index];
                    return FavoriteTile(element.id);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
        }),
      ),
    );
  }
}
