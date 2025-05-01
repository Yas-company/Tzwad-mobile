import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';
import '../home/all_products.dart';
import '../home/product_card.dart';
import '../utils/constant_name.dart';
import '../utils/image_view.dart';
import '../utils/text_themes.dart';
import '../../service/cart_data_service.dart';
import '../../view/details/review_box.dart';
import '../../service/favorite_data_service.dart';
import '../../service/product_details_service.dart';
import '../../view/details/animated_box.dart';
import '../../view/details/plus_minus_cart.dart';
import '../../view/intro/dot_indicator.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = 'product details screen';
  ProductDetails({Key? key}) : super(key: key);
  TextStyle attributeTitleTheme =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    // initiateDeviceSize(context);
    dynamic id;
    if (ModalRoute.of(context) != null) {
      final routeData = ModalRoute.of(context)!.settings.arguments as List;
      id = routeData[0];
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: FutureBuilder(
          future: Provider.of<ProductDetailsService>(context, listen: false)
              .fetchProductDetails(id: id, nextProduct: true),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return loadingProgressBar();
            }
            if (Provider.of<ProductDetailsService>(context, listen: false)
                    .productDetails ==
                null) {
              return Center(
                  child: Text(asProvider.getString('Loading failed!')));
            }

            return Provider.of<ProductDetailsService>(context).refreshpage
                ? SizedBox()
                : Column(
                    children: [
                      Consumer<ProductDetailsService>(
                          builder: (context, pService, child) {
                        final product = pService.productDetails!.product;
                        bool showAttribute = pService
                            .productDetails!.productInventorySet.isNotEmpty;
                        return Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverAppBar(
                                elevation: 1,
                                foregroundColor: cc.greyHint,
                                expandedHeight: screenWidth / 1.37,
                                systemOverlayStyle: SystemUiOverlayStyle.dark,
                                pinned: true,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: pService.additionalInfoImage !=
                                              null ||
                                          product.productGalleryImage.isEmpty
                                      ? Container(
                                          width: double.infinity,
                                          margin: EdgeInsets.only(
                                              top: MediaQuery.of(context)
                                                  .padding
                                                  .top),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ImageView(
                                                    pService.additionalInfoImage ??
                                                        product.image,
                                                    id: product.id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              pService.additionalInfoImage ??
                                                  product.image,
                                              fit: BoxFit.cover,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Container(
                                                  width: double.infinity,
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 60),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/product_skelleton.png'),
                                                          opacity: .4)),
                                                );
                                              },
                                              errorBuilder: (context, o, st) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 60),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/product_skelleton.png'),
                                                          opacity: .4)),
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : Swiper(
                                          loop: false,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Hero(
                                              tag: id,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    top: MediaQuery.of(context)
                                                        .padding
                                                        .top),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute<void>(
                                                        builder: (BuildContext
                                                                context) =>
                                                            ImageView(
                                                          product.productGalleryImage[
                                                              index],
                                                          id: product.id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 60),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    'assets/images/product_skelleton.png'),
                                                                opacity: .4)),
                                                      ),
                                                      imageUrl: pService
                                                              .additionalInfoImage ??
                                                          (product.productGalleryImage
                                                                  .isEmpty
                                                              ? product.image
                                                              : product
                                                                      .productGalleryImage[
                                                                  index]),
                                                      errorWidget: (context,
                                                              errorText,
                                                              error) =>
                                                          Image.network(
                                                        product.image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: product
                                              .productGalleryImage.length,
                                          pagination: pService
                                                          .additionalInfoImage !=
                                                      null ||
                                                  product.productGalleryImage
                                                      .isEmpty ||
                                                  product.productGalleryImage
                                                          .length <=
                                                      1
                                              ? null
                                              : SwiperCustomPagination(
                                                  builder:
                                                      (BuildContext context,
                                                          SwiperPluginConfig
                                                              config) {
                                                    return Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                for (int i = 0;
                                                                    i <
                                                                        product
                                                                            .productGalleryImage
                                                                            .length;
                                                                    i++)
                                                                  (i == config.activeIndex
                                                                      ? DotIndicator(
                                                                          true)
                                                                      : DotIndicator(
                                                                          false))
                                                              ]),
                                                        ));
                                                  },
                                                ),
                                        ),
                                ),
                                leading: GestureDetector(
                                  onTap: (() {
                                    Navigator.of(context).pop();
                                  }),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform(
                                          transform:
                                              Provider.of<LanguageService>(
                                                          context,
                                                          listen: false)
                                                      .rtl
                                                  ? Matrix4.rotationY(pi)
                                                  : Matrix4.rotationY(0),
                                          child: SvgPicture.asset(
                                            'assets/images/icons/back_button.svg',
                                            color: cc.blackColor,
                                            height: 30,
                                          ),
                                        ),
                                      ]),
                                ),
                                actions: [
                                  Consumer<FavoriteDataService>(
                                      builder: (context, favoriteData, child) {
                                    return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: favoriteIcon(
                                            favoriteData.isfavorite(
                                                product.id.toString()),
                                            size: 18, onPressed: () {
                                          favoriteData.toggleFavorite(
                                              context,
                                              product.id,
                                              product.title,
                                              pService.productSalePrice
                                                  .toDouble(),
                                              product.image,
                                              pService.productDetails!
                                                  .productInventorySet.isEmpty);
                                        }
                                            // => favoriteData.toggleFavorite(
                                            //     product.id,
                                            //     product: product)
                                            ));
                                  }),
                                ],
                              ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  [
                                    const SizedBox(height: 20),

                                    //title Row
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: screenWidth / 2,
                                                  child: Text(
                                                    product.title,
                                                    style: const TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 19,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                const SizedBox(height: 17),
                                                discountAmountRow(
                                                    context,
                                                    pService.productSalePrice
                                                        .toDouble(),
                                                    product.price.toDouble(),
                                                    campDisc: product
                                                        .campaignPercentage),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: screenWidth / 3.2,
                                            height: 60,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                if (Provider.of<ProductDetailsService>(
                                                            context,
                                                            listen: false)
                                                        .productDetails!
                                                        .avgRating !=
                                                    null)
                                                  RatingBar.builder(
                                                    ignoreGestures: true,
                                                    itemSize: 17,
                                                    initialRating: (Provider.of<
                                                                            ProductDetailsService>(
                                                                        context,
                                                                        listen:
                                                                            false)
                                                                    .productDetails!
                                                                    .avgRating ??
                                                                0)
                                                            .toDouble() ??
                                                        0.0,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: false,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1),
                                                    itemBuilder: (context, _) =>
                                                        SvgPicture.asset(
                                                      'assets/images/icons/star.svg',
                                                      color: cc.orangeRating,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                const SizedBox(height: 17),
                                                Text(
                                                  asProvider.getString(
                                                          'In Stock') +
                                                      ' (${product.inventory.stockCount.toString()})',
                                                  style: TextThemeConstrants
                                                      .primary13,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 20),

                                    if (showAttribute)
                                      Consumer<ProductDetailsService>(
                                          builder: (context, pdService, child) {
                                        // generateAttributeWidgets(pdService);
                                        return !showAttribute
                                            ? const SizedBox()
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children:
                                                          pdService
                                                              .inventoryKeys
                                                              .map(
                                                                  (e) =>
                                                                      Container(
                                                                        alignment: Provider.of<LanguageService>(context, listen: false).rtl
                                                                            ? Alignment.centerRight
                                                                            : Alignment.centerLeft,
                                                                        margin: EdgeInsets.only(
                                                                            bottom:
                                                                                15),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Text('${e.replaceFirst('_', ' ')}:',
                                                                                style: attributeTitleTheme),
                                                                            const SizedBox(width: 10),
                                                                            Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: generateDynamicAttrribute(context, pdService, e, pdService.allAttributes[e])))),
                                                                          ],
                                                                        ),
                                                                      ))
                                                              .toList()),
                                                ),
                                              );
                                      }),
                                    AnimatedBox(
                                      asProvider.getString('Description'),
                                      {
                                        '1': product.description.isEmpty
                                            ? asProvider.getString(
                                                'No description available.')
                                            : product.description
                                      },
                                      pService.descriptionExpand,
                                      onPressed:
                                          pService.toggleDescriptionExpande,
                                    ),

                                    AnimatedBox(
                                      asProvider.getString(
                                        'Additional Information',
                                      ),
                                      pService.setAditionalInfo(),
                                      pService.aDescriptionExpand,
                                      onPressed:
                                          pService.toggleADescriptionExpande,
                                    ),
                                    ReviewBox(
                                      pService.reviewExpand,
                                      pService.productDetails!.product.id,
                                      onPressed: pService.toggleReviewExpand,
                                    ),

                                    const SizedBox(height: 10),
                                    if (pService.productDetails!.relatedProducts
                                        .isNotEmpty)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: seeAllTitle(
                                            context,
                                            asProvider
                                                .getString('Related products'),
                                            onPressed: () {
                                          // Provider.of<SearchResultDataService>(
                                          //         context,
                                          //         listen: false)
                                          //     .resetSerch();
                                          // Provider.of<SearchResultDataService>(
                                          //         context,
                                          //         listen: false)
                                          //     .fetchProductsBy(pageNo: '1');
                                          // Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              AllProducts.routeName,
                                              arguments: [
                                                pService.productDetails!
                                                    .relatedProducts,
                                                asProvider.getString(
                                                    'Related products'),
                                                true
                                              ]);
                                        }),
                                      ),
                                    const SizedBox(height: 10),
                                    if (pService.productDetails!.relatedProducts
                                        .isNotEmpty)
                                      SizedBox(
                                          height: screenHight / 3.4 < 221
                                              ? 200
                                              : screenHight / 3.4,
                                          child: ListView.builder(
                                            physics: const BouncingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: pService.productDetails!
                                                .relatedProducts.length,
                                            itemBuilder: (context, index) {
                                              final products = pService
                                                  .productDetails!
                                                  .relatedProducts[index];
                                              return ProductCard(
                                                products.prdId,
                                                products.title,
                                                products.price,
                                                products.discountPrice ?? 0,
                                                (products.campaignPercentage)
                                                    .toDouble(),
                                                products.imgUrl,
                                                false,
                                                null,
                                                popFirst: true,
                                              );
                                            },
                                          )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      Consumer<ProductDetailsService>(
                          builder: (context, pService, child) {
                        final product = pService.productDetails!.product;
                        return Container(
                            height: 90,
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 23,
                              top: 17,
                              bottom: 7,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              ),
                              color: cc.blackColor,
                            ),
                            child: PlusMinusCart(
                              onTap: pService.cartAble
                                  ? () {
                                      Provider.of<CartDataService>(context,
                                              listen: false)
                                          .addCartItem(
                                        context,
                                        product.id,
                                        product.title,
                                        pService.productSalePrice.toDouble(),
                                        pService.productSalePrice.toDouble(),
                                        0.0,
                                        pService.quantity,
                                        pService.additionalInfoImage ??
                                            product.image,
                                        inventorySet:
                                            pService.selectedInventorySet == {}
                                                ? null
                                                : pService.selectedInventorySet,
                                        hash: pService.selectedInventoryHash,
                                      );
                                    }
                                  : () {
                                      snackBar(
                                          context,
                                          asProvider.getString(
                                              'Select all attribute to proceed.'),
                                          backgroundColor: cc.orange);
                                    },
                            ));
                      }),
                    ],
                  );
          },
        ),
      ),
    );
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
                            size: 17,
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

  Widget discountAmountRow(
      BuildContext context, double discountAmount, double amount,
      {campDisc}) {
    return Row(
      children: [
        Consumer<LanguageService>(builder: (context, lService, child) {
          return Text(
            lService.currencyRTL
                ? '${discountAmount <= 0 ? amount.toString() : discountAmount.toStringAsFixed(2)}${lService.currency}'
                : '${lService.currency}${discountAmount <= 0 ? amount.toString() : discountAmount.toStringAsFixed(2)}',
            style: TextStyle(
                color: cc.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          );
        }),
        const SizedBox(width: 4),
        Consumer<LanguageService>(builder: (context, lService, child) {
          return Text(
            lService.currencyRTL
                ? '${amount.toStringAsFixed(2)}${lService.currency}'
                : '${lService.currency}${amount.toStringAsFixed(2)}',
            style: TextStyle(
                color: cc.cardGreyHint,
                decoration: TextDecoration.lineThrough,
                decorationColor: cc.cardGreyHint,
                fontSize: 13),
          );
        }),
        if (campDisc != null && campDisc > 0) SizedBox(width: 15),
        if (campDisc != null && campDisc > 0)
          Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7), color: cc.orange),
              child: Text(
                '%$campDisc',
                style: TextStyle(color: cc.pureWhite, fontSize: 13),
              ))
      ],
    );
  }
}
