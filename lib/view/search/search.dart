import 'package:flutter/material.dart';
import 'package:gren_mart/service/navigation_bar_helper_service.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import '../../service/search_result_data_service.dart';
import '../../view/home/product_card.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/constant_styles.dart';

class SearchView extends StatelessWidget {
  static const routeName = 'search';
  SearchView();
  ConstantColors cc = ConstantColors();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    double cardWidth = screenWidth / 3.3;
    // double cardHeight = screenHight / 5.4;
    double cardHeight = screenHight / 5.4 < 144 ? 130 : screenHight / 5.4;
    controller.addListener((() => scrollListener(context)));
    return WillPopScope(
      onWillPop: () =>
          Provider.of<NavigationBarHelperService>(context, listen: false)
              .setNavigationIndex(0),
      child:
          Consumer<SearchResultDataService>(builder: (context, srData, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                child: Consumer<SearchResultDataService>(
                    builder: (context, srService, child) {
                  return TextFormField(
                    initialValue: srData.searchText,
                    style:
                        TextStyle(color: cc.greyTextFieldLebel, fontSize: 13),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 17),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: cc.primaryColor, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cc.greyBorder, width: 1),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cc.orange, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: cc.orange, width: 1),
                      ),
                      hintText: asProvider.getString('Search your need here'),

                      hintStyle:
                          TextStyle(color: cc.greyTextFieldLebel, fontSize: 13),

                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              child: Image.asset(
                                'assets/images/icons/search_normal.png',
                              )),
                        ],
                      ),
                      suffixIcon: GestureDetector(
                        onTap: (() {
                          FocusScope.of(context).unfocus();
                          Provider.of<SearchResultDataService>(context,
                                  listen: false)
                              .resetSerch();
                          Provider.of<SearchResultDataService>(context,
                                  listen: false)
                              .fetchProductsBy(pageNo: '1');
                        }),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: cc.blackColor,
                          size: 17,
                        ),
                      ),
                      //  if (leadingImage != null)?
                    ),
                    onFieldSubmitted: (_) {
                      Provider.of<SearchResultDataService>(context,
                              listen: false)
                          .resetSerch();
                      Provider.of<SearchResultDataService>(context,
                              listen: false)
                          .fetchProductsBy(pageNo: '1');
                    },
                    onChanged: (value) {
                      Provider.of<SearchResultDataService>(context,
                              listen: false)
                          .setSearchText(value);
                    },
                  );
                })),
            const SizedBox(height: 20),
            Expanded(
                child: (srData.resultMeta != null || srData.error)
                    ? newMethod(cardWidth, cardHeight, srData)
                    : loadingProgressBar()
                //  FutureBuilder(
                //     future: showTimout(),
                //     builder: ((context, snapshot) {
                //       if (snapshot.connectionState ==
                //           ConnectionState.waiting) {
                //         return loadingProgressBar();
                //       }
                //       snackBar(context, 'Timeout!',
                //           backgroundColor: cc.orange);
                //       return Center(
                //         child: Text(
                //           'Loading failed!',
                //           style: TextStyle(color: cc.greyHint),
                //         ),
                //       );
                //     }),
                //   ),
                ),
            if (srData.isLoading) loadingProgressBar(),
            // if (srData.resultMeta!.lastPage < pageNo)
          ],
          // ),
        );
      }),
    );
  }

  Widget newMethod(
      double cardWidth, double cardHeight, SearchResultDataService srData) {
    if (srData.noProduct) {
      return Center(
        child: Text(
          asProvider.getString('No data has been found!'),
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else if (srData.error) {
      return Center(
        child: Text(
          asProvider.getString('Loading failed!'),
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else {
      return GridView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, bottom: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: cardWidth / cardHeight,
          crossAxisSpacing: 12,
          // mainAxisSpacing: 12
        ),
        itemCount: srData.searchResult.length,
        itemBuilder: (context, index) {
          final e = srData.searchResult[index];
          // if (srData.resultMeta!.lastPage >= pageNo) {
          return ProductCard(e.prdId, e.title, e.price, e.discountPrice,
              e.campaignPercentage, e.imgUrl, e.isCartAble, e.badge);
        },
      );
    }
  }

  scrollListener(BuildContext context) {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (Provider.of<SearchResultDataService>(context, listen: false)
          .isLoading) {
        return;
      }
      Provider.of<SearchResultDataService>(context, listen: false)
          .setIsLoading(true);

      Provider.of<SearchResultDataService>(context, listen: false)
          .fetchProductsBy(
              pageNo:
                  Provider.of<SearchResultDataService>(context, listen: false)
                      .pageNumber
                      .toString())
          .then((value) {
        if (value != null) {
          snackBar(context, value, backgroundColor: cc.orange);
        }
      });
      Provider.of<SearchResultDataService>(context, listen: false).nextPage();
    }
  }

  Future<bool> showTimout() async {
    await Future.delayed(const Duration(seconds: 10));
    return true;
  }
}
