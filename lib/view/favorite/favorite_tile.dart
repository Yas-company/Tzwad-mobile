import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/service/cart_data_service.dart';
import 'package:gren_mart/service/product_details_service.dart';
import 'package:gren_mart/view/details/product_details.dart';
import 'package:gren_mart/view/favorite/favorite_to_cart.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../service/favorite_data_service.dart';
import '../../service/language_service.dart';
import '../../view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

import '../utils/text_themes.dart';

class FavoriteTile extends StatelessWidget {
  final dynamic id;

  FavoriteTile(this.id, {Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteDataService>(
        builder: (context, favoriteData, child) {
      final favoriteItem = favoriteData.favoriteItems.values
          .toList()
          .firstWhere((element) => element.id == id);
      return Dismissible(
        dragStartBehavior: DragStartBehavior.start,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          color: cc.pink,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              Text(
                asProvider.getString('Delete'),
                style: TextStyle(color: cc.pureWhite, fontSize: 17),
              ),
              const SizedBox(width: 15),
              SvgPicture.asset(
                'assets/images/icons/trash.svg',
                height: 22,
                width: 22,
                color: cc.pureWhite,
              ),
            ],
          ),
        ),
        onDismissed: (direction) {
          favoriteData.deleteFavoriteItem(id, context);
        },
        key: Key(id.toString()),
        child: SizedBox(
          height: 75,
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(ProductDetails.routeName, arguments: [id]);
                },
                leading: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      //  const BorderRadius.only(
                      //     topLeft: Radius.circular(10),
                      //     topRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: favoriteItem.imgUrl,
                        placeholder: (context, url) => Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/product_skelleton.png'),
                                  opacity: .4)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/product_skelleton.png'),
                                  opacity: .4)),
                        ),
                      ),
                    )),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth / 2.5,
                            child: Text(
                              favoriteItem.title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          const SizedBox(height: 13),
                          Consumer<LanguageService>(
                              builder: (context, lService, child) {
                            return Text(
                              lService.currencyRTL
                                  ? '${favoriteItem.price}${lService.currency}'
                                  : '${lService.currency}${favoriteItem.price}',
                              style: TextThemeConstrants.primary13,
                            );
                          }),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: (() async {
                        if (!favoriteItem.attribute) {
                          Provider.of<ProductDetailsService>(context,
                                  listen: false)
                              .resetDetails();
                          print(favoriteItem.attribute);
                          await showModalBottomSheet(
                              context: context,
                              enableDrag: true,
                              builder: (context) {
                                bool fetchAttribute = true;
                                return SingleChildScrollView(
                                  child: FavoriteToCart(id),
                                );
                              });

                          return;
                        }
                        Provider.of<CartDataService>(context, listen: false)
                            .addCartItem(
                                context,
                                id,
                                favoriteItem.title,
                                favoriteItem.price,
                                favoriteItem.price,
                                0.0,
                                1,
                                favoriteItem.imgUrl);
                        favoriteData.deleteFavoriteItem(id, context);
                      }),
                      child: Container(
                        padding: const EdgeInsets.only(left: 7),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: SvgPicture.asset(
                          'assets/images/icons/send_to_cart.svg',
                          height: 26,
                          color: cc.primaryColor,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() async {
                        bool deleteItem = false;
                        await confirmDialouge(context,
                            onPressed: () => deleteItem = true);
                        if (deleteItem) {
                          favoriteData.deleteFavoriteItem(id, context);
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: SvgPicture.asset(
                          'assets/images/icons/trash.svg',
                          height: 22,
                          width: 22,
                          color: cc.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // if (!(CartData().cartList.last == ele)) const Divider(),
            ],
          ),
        ),
      );
    });
  }

  Future confirmDialouge(BuildContext context,
      {required void Function() onPressed}) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(asProvider.getString('Are you sure?')),
              content: Text(asProvider.getString('This Item will be Deleted.')),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text(
                      asProvider.getString('No'),
                      style: TextStyle(color: cc.primaryColor),
                    )),
                TextButton(
                    onPressed: () {
                      onPressed();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      asProvider.getString('Yes'),
                      style: TextStyle(color: cc.pink),
                    ))
              ],
            ));
  }
}
