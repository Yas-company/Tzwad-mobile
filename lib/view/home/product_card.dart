import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/cart_data_service.dart';
import '../../service/favorite_data_service.dart';
import '../../service/language_service.dart';
import '../../view/details/product_details.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/constant_styles.dart';

class ProductCard extends StatelessWidget {
  final dynamic _id;
  final String title;
  final num price;
  final double campaignPercentage;
  final String imgUrl;
  final num discountPrice;
  final bool isCartable;
  bool popFirst;
  bool popProductList;
  String? badge;

  EdgeInsetsGeometry? margin;

  ProductCard(
    this._id,
    this.title,
    this.price,
    this.discountPrice,
    this.campaignPercentage,
    this.imgUrl,
    this.isCartable,
    this.badge, {
    Key? key,
    this.margin = const EdgeInsets.all(1),
    this.popFirst = false,
    this.popProductList = false,
  }) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    final rtl = Provider.of<LanguageService>(context, listen: false).rtl;
    initiateDeviceSize(context);
    return GestureDetector(
      onTap: () {
        if (popFirst) {
          Navigator.of(context).pop();
        }
        if (popProductList) {
          Navigator.pop(context, true);
          Navigator.pop(context, true);
          print('poping all product');
        }
        Navigator.of(context).pushNamed(ProductDetails.routeName,
            arguments: [_id]).then((value) {});
      },
      child: Container(
        width: screenWidth / 2.57,
        height: screenHight / 3.6,
        margin: margin != null
            ? EdgeInsets.only(right: rtl ? 0 : 18, left: rtl ? 18 : 0)
            : null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cc.pureWhite,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: screenHight / 8,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      color: cc.whiteGrey),
                  child:
                      // Hero(
                      //   tag: product.id,
                      //   child:
                      ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    //  const BorderRadius.only(
                    //     topLeft: Radius.circular(10),
                    //     topRight: Radius.circular(10)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: imgUrl,
                      placeholder: (context, url) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/product_skelleton.png'),
                                opacity: .4)),
                      ),
                      errorWidget: (context, url, error) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/product_skelleton.png'),
                                opacity: .4)),
                      ),
                    ),
                  ),
                  // ),
                ),
                badge == null || badge == ''
                    ? SizedBox()
                    : Container(
                        margin: const EdgeInsets.symmetric(vertical: 13),
                        constraints: const BoxConstraints(maxWidth: 50),
                        padding: const EdgeInsets.symmetric(
                            vertical: 3, horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Radius.zero
                                : Radius.circular(5),
                            bottomRight: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Radius.zero
                                : Radius.circular(5),
                            topLeft: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Radius.circular(5)
                                : Radius.zero,
                            bottomLeft: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? Radius.circular(5)
                                : Radius.zero,
                          ),
                          color: cc.pureWhite,
                        ),
                        child: Text(
                          '$badge',
                          maxLines: 1,
                          style: TextStyle(
                            color: cc.blackColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                if (campaignPercentage > 0)
                  Container(
                    margin: badge == null || badge == ''
                        ? const EdgeInsets.symmetric(vertical: 13)
                        : const EdgeInsets.only(top: 35),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? Radius.zero
                                : Radius.circular(5),
                        bottomRight:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? Radius.zero
                                : Radius.circular(5),
                        topLeft:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? Radius.circular(5)
                                : Radius.zero,
                        bottomLeft:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? Radius.circular(5)
                                : Radius.zero,
                      ),
                      color: cc.orange,
                    ),
                    child: Text(
                      '${campaignPercentage.toString()}%',
                      style: TextStyle(
                          color: cc.pureWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                Consumer<FavoriteDataService>(
                    builder: (context, favoriteData, child) {
                  return Positioned(
                      right:
                          Provider.of<LanguageService>(context, listen: false)
                                  .rtl
                              ? null
                              : 0,
                      left: Provider.of<LanguageService>(context, listen: false)
                              .rtl
                          ? 0
                          : null,
                      child:
                          favoriteIcon(favoriteData.isfavorite(_id.toString()),
                              onPressed: () => favoriteData.toggleFavorite(
                                    context,
                                    _id,
                                    title,
                                    discountPrice.toDouble(),
                                    imgUrl,
                                    isCartable,
                                  )));
                })
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  discAmountRow(
                      context,
                      discountPrice.toInt(),
                      price.toInt(),
                      Provider.of<LanguageService>(context, listen: false)
                          .currency),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushReplacementNamed(Auth.routeName);
                    },
                    child: Consumer<CartDataService>(
                      builder: (context, cartData, child) {
                        return GestureDetector(
                          onTap: isCartable
                              ? () {
                                  cartData.addCartItem(
                                      context,
                                      _id,
                                      title,
                                      discountPrice.toDouble(),
                                      discountPrice.toDouble(),
                                      campaignPercentage,
                                      1,
                                      imgUrl);
                                  snackBar(
                                      context,
                                      asProvider
                                          .getString('Product added to cart.'));
                                }
                              : (() {
                                  if (popFirst) {
                                    Navigator.of(context).pop();
                                  }
                                  Navigator.of(context).pushNamed(
                                      ProductDetails.routeName,
                                      arguments: [_id]);
                                }),
                          child: child,
                        );
                      },
                      child: Container(
                          height: screenWidth / 10,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: cc.primaryColor,
                            ),
                          ),
                          child: Text(
                            isCartable
                                ? asProvider.getString('Add to cart')
                                : asProvider.getString('View details'),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: cc.primaryColor,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
