import 'package:flutter/material.dart';
import 'package:gren_mart/service/favorite_data_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';

import '../../service/cart_data_service.dart';
import '../../service/language_service.dart';
import '../../service/product_details_service.dart';
import '../utils/constant_styles.dart';

class FavoriteToCart extends StatelessWidget {
  final dynamic id;
  bool fetchAttribute = true;

  FavoriteToCart(this.id, {Key? key}) : super(key: key);

  TextStyle attributeTitleTheme =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsService>(
      builder: (context, pdService, child) {
        pdService
            .fetchProductDetails(id: id, nextProduct: fetchAttribute)
            .onError((error, stackTrace) {
          Navigator.of(context).pop();
          snackBar(context, asProvider.getString('Connection failed.'),
              backgroundColor: cc.orange);
        });
        fetchAttribute = false;
        return pdService.loadingFailed
            ? SizedBox(
                height: 100,
                child: Center(
                  child: Text(asProvider.getString('Connection Failed.')),
                ))
            : (SingleChildScrollView(
                child: pdService.productDetails == null
                    ? loadingProgressBar()
                    :
                    // FutureBuilder(
                    //     future: pdService.fetchProductDetails(
                    //         id: id, nextProduct: fetchAttribute),
                    //     builder: (context, snapshot) {
                    //       fetchAttribute = false;
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return SizedBox(height: 60, child: loadingProgressBar());
                    // }
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 300,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  pdService.additionalInfoImage ??
                                      pdService.productDetails!.product.image,
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/product_skelleton.png'),
                                              opacity: .4)),
                                    );
                                  },
                                  errorBuilder: (context, o, st) {
                                    return Container(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/product_skelleton.png'),
                                              opacity: .4)),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                asProvider.getString('Select attributes:'),
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: pdService.inventoryKeys
                                  .map((e) => Container(
                                        alignment: Provider.of<LanguageService>(
                                                    context,
                                                    listen: false)
                                                .rtl
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        margin: EdgeInsets.only(bottom: 15),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text('${e.replaceFirst('_', ' ')}:',
                                                style: attributeTitleTheme),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                      children:
                                                          generateDynamicAttrribute(
                                                              context,
                                                              pdService,
                                                              e,
                                                              pdService
                                                                      .allAttributes[
                                                                  e]))),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                            Consumer<LanguageService>(
                                builder: (context, lService, child) {
                              return customContainerButton(
                                  pdService.cartAble
                                      ? (lService.currencyRTL
                                              ? '${pdService.productSalePrice}${lService.currency}'
                                              : '${lService.currency}${pdService.productSalePrice}') +
                                          asProvider.getString('Add to cart.')
                                      : asProvider.getString(
                                          'Select all attribute to proceed'),
                                  double.infinity, () {
                                if (!pdService.cartAble) {
                                  return;
                                }
                                final product =
                                    pdService.productDetails!.product;
                                Provider.of<CartDataService>(context,
                                        listen: false)
                                    .addCartItem(
                                  context,
                                  product.id,
                                  product.title,
                                  pdService.productSalePrice.toDouble(),
                                  pdService.productSalePrice.toDouble(),
                                  0.0,
                                  pdService.quantity,
                                  pdService.additionalInfoImage ??
                                      product.image,
                                  inventorySet:
                                      pdService.selectedInventorySet == {}
                                          ? null
                                          : pdService.selectedInventorySet,
                                  hash: pdService.selectedInventoryHash,
                                );
                                Provider.of<FavoriteDataService>(context,
                                        listen: false)
                                    .deleteFavoriteItem(id, context);
                                Navigator.of(context).pop();
                              },
                                  color: pdService.cartAble
                                      ? cc.primaryColor
                                      : cc.greyBorder);
                            })
                          ],
                        ),
                      )
                //   },
                // ),
                ));
      },
    );
  }

  List<Widget> generateDynamicAttrribute(BuildContext context,
      ProductDetailsService pdService, fieldName, mapdata) {
    RegExp hex = RegExp(
        r'^#([\da-f]{3}){1,2}$|^#([\da-f]{4}){1,2}$|(rgb|hsl)a?\((\s*-?\d+%?\s*,){2}(\s*-?\d+%?\s*,?\s*\)?)(,\s*(0?\.\d+)?|1)?\)');

    List<Widget> list = [];
    String value = '';
    final keys = mapdata.keys;
    for (var elemnt in keys) {
      list.add(
        GestureDetector(
          onTap: () {
            if (pdService.selectedAttributes.contains(elemnt)) {
              return;
            }
            if (!pdService.isInSet(fieldName, elemnt, mapdata[elemnt])) {
              pdService.clearSelection();
            }
            pdService.setProductInventorySet(mapdata[elemnt]);
            value = elemnt;
            manageInventorySet(pdService, elemnt);
            pdService.addSelectedAttribute(elemnt);
            pdService.addAdditionalPrice();
          },
          child: hex.hasMatch(elemnt)
              ? colorBox(context, pdService, fieldName, elemnt, mapdata)
              : Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 3,
                          right: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 0
                              : 15,
                          left: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 15
                              : 0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: pdService.isASelected(elemnt)
                              ? cc.lightPrimery3
                              : cc.whiteGrey,
                          border: Border.all(
                              color: pdService.isASelected(elemnt)
                                  ? cc.primaryColor
                                  : cc.greyHint,
                              width: .5)),
                      child: Text(elemnt),
                    ),
                    if (pdService.isASelected(elemnt))
                      Positioned(
                        right: 9,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: cc.pureWhite),
                          child: Icon(
                            Icons.check_circle,
                            color: cc.primaryColor,
                            size: 15,
                          ),
                        ),
                      ),
                    if (!pdService.isInSet(fieldName, elemnt, mapdata[elemnt]))
                      Container(
                        margin: EdgeInsets.only(
                            top: 3,
                            right: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? 0
                                : 15,
                            left: Provider.of<LanguageService>(context,
                                        listen: false)
                                    .rtl
                                ? 15
                                : 0),
                        padding: const EdgeInsets.all(12),
                        color: Colors.white60,
                        child: Text(
                          elemnt,
                          style: const TextStyle(color: Colors.transparent),
                        ),
                      )
                  ],
                ),
        ),
      );
    }
    return list;
  }

  manageInventorySet(
    ProductDetailsService pdService,
    selectedValue,
  ) {
    final selectedInventorySetIndex = pdService.selectedInventorySetIndex;
    final allAtrributes = pdService.allAttributes;
    setProductInventorySet(List<String>? value) {
      // print(
      //     selectedInventorySetIndex.toString() + 'inven........................');
      // print(value.toString() + 'val........................');

      if (selectedInventorySetIndex != value) {
        // if (value!.length == 1) {
        //   selectedInventorySetIndex = value;selectedValue
        // print(selectedInventorySetIndex);
        pdService.inventoryKeys.forEach((element) {
          if (selectedValue != null) {
            selectedValue = pdService.deselect(
                    value, allAtrributes[element]![selectedValue])
                ? selectedValue
                : null;
          }
        });
      }
      if (selectedInventorySetIndex.isEmpty) {
        pdService.selectedInventorySetIndex = value ?? [];

        return;
      }
      if (selectedInventorySetIndex.isNotEmpty &&
          selectedInventorySetIndex.length > value!.length) {
        pdService.selectedInventorySetIndex = value;
        return;
      }
    }
  }

  Widget colorBox(BuildContext context, ProductDetailsService pdService,
      fieldName, value, mapdata) {
    final color = value.replaceAll('#', '0xff');
    return Stack(
      children: [
        Container(
          height: 40,
          width: 40,
          margin: EdgeInsets.only(
              top: 3,
              right: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 0
                  : 15,
              left: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 15
                  : 0),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(int.parse(color)),
          ),
          // child: const Text('element.color!.capitalize()'),
        ),
        if (pdService.isASelected(value))
          Positioned(
            right: 9,
            top: 0,
            child: Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: cc.pureWhite),
              child: Icon(
                Icons.check_circle,
                color: cc.primaryColor,
                size: 15,
              ),
            ),
          ),
        if (!pdService.isInSet(fieldName, value, mapdata[value]))
          Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(
                top: 3,
                right: Provider.of<LanguageService>(context, listen: false).rtl
                    ? 0
                    : 15,
                left: Provider.of<LanguageService>(context, listen: false).rtl
                    ? 15
                    : 0),
            padding: const EdgeInsets.all(12),
            color: Colors.white60,
            child: Text(
              value,
              style: const TextStyle(color: Colors.transparent),
            ),
          )
      ],
    );
  }
}
