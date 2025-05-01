import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gren_mart/service/language_service.dart';
import 'package:provider/provider.dart';

import '../utils/constant_styles.dart';
import '../../view/details/product_details.dart';
import '../../view/utils/text_themes.dart';
import '../../view/utils/constant_name.dart';
import '../../service/cart_data_service.dart';

class CartTile extends StatelessWidget {
  final dynamic id;
  final String name;
  final String image;
  final int quantity;
  final double price;
  Map? inventorySet;
  CartTile(
    this.id,
    this.name,
    this.image,
    this.quantity,
    this.price,
    this.inventorySet, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final carts = Provider.of<CartDataService>(context, listen: false);
    return Dismissible(
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
        snackBar(context, asProvider.getString('Item removed from cart.'),
            backgroundColor: cc.orange);
        carts.deleteCartItem(id, inventorySet: inventorySet ?? {});
      },
      key: Key(id.toString()),
      child: SizedBox(
        height: screenWidth / 4.3,
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProductDetails.routeName, arguments: [id]);
              },
              leading: Container(
                  height: screenWidth / 4.3,
                  width: screenWidth / 7,
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
                      imageUrl: image,
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
                          width: screenWidth / 3,
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        const SizedBox(height: 13),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              lService.currencyRTL
                                  ? '${price.toStringAsFixed(2)}${lService.currency} '
                                  : '${lService.currency}${price.toStringAsFixed(2)} ',
                              style: TextThemeConstrants.primary13,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: cc.pureWhite,
                        border: Border.all(
                            width: .4, color: cc.greyTextFieldLebel)),
                    height: 48,
                    width: 105,
                    child: Consumer<CartDataService>(
                        builder: (context, cart, child) {
                      return Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cc.pink.withOpacity(0.10),
                            ),
                            child: IconButton(
                                // padding: EdgeInsets.zero,
                                onPressed: () {
                                  cart.minusItem(id, context,
                                      inventorySet: inventorySet ?? {});
                                },
                                icon: SvgPicture.asset(
                                  'assets/images/icons/minus.svg',
                                  color: cc.pink,
                                )),
                          ),
                          Expanded(
                              child: Text(
                            quantity.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: cc.blackColor,
                                fontWeight: FontWeight.w600),
                          )),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cc.primaryColor.withOpacity(.10),
                            ),
                            child: IconButton(
                                onPressed: () => cart.addItem(context, id,
                                    inventorySet: inventorySet ?? {}),
                                icon: SvgPicture.asset(
                                  'assets/images/icons/add.svg',
                                  color: cc.primaryColor,
                                )),
                          ),
                        ],
                      );
                    }),
                  ),
                  GestureDetector(
                    onTap: (() async {
                      bool deleteItem = false;

                      await confirmDialouge(context,
                          onPressed: () => deleteItem = true);
                      if (deleteItem) {
                        snackBar(context,
                            asProvider.getString('Item removed from cart.'),
                            backgroundColor: cc.orange);
                        carts.deleteCartItem(id,
                            inventorySet: inventorySet ?? {});
                      }
                    }),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? 0
                                : 7,
                        right:
                            Provider.of<LanguageService>(context, listen: false)
                                    .rtl
                                ? 7
                                : 0,
                      ),
                      child: SvgPicture.asset(
                        'assets/images/icons/trash.svg',
                        height: 22,
                        width: 22,
                        color: const Color(0xffFF4065),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // if (!(CartData().cartList.values.last.id == id))
            const Divider(),
          ],
        ),
      ),
    );
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
