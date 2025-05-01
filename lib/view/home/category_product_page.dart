import 'package:flutter/material.dart';
import 'package:gren_mart/service/search_result_data_service.dart';
import 'package:gren_mart/view/home/bottom_navigation_bar.dart';
import 'package:gren_mart/view/utils/app_bars.dart';
import 'package:provider/provider.dart';

import '../utils/constant_name.dart';
import '../utils/constant_styles.dart';
import 'product_card.dart';

class CategoryProductPage extends StatelessWidget {
  static const routeName = 'category product page';
  CategoryProductPage({Key? key}) : super(key: key);
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    controller.addListener((() => scrollListener(context)));
    final routeData =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final id = routeData[0];
    final title = routeData[1];
    double cardWidth = screenWidth / 3.3;
    double cardHeight = screenHight / 5.5 < 130 ? 130 : screenHight / 5.5;

    return Scaffold(
      appBar: AppBars().appBarTitled(context, '$title', () {
        Navigator.of(context).pop();
      }),
      body: WillPopScope(
        onWillPop: (() async {
          Provider.of<SearchResultDataService>(context, listen: false)
              .resetSerch();
          Provider.of<SearchResultDataService>(context, listen: false)
              .resetSerchFilters();
          return true;
        }),
        child: FutureBuilder(
          future: Provider.of<SearchResultDataService>(context, listen: false)
              .fetchProductsBy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingProgressBar();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  asProvider.getString('Loading failed!'),
                  style: TextStyle(color: cc.greyHint),
                ),
              );
            }
            if (snapshot.hasData) {
              return Center(
                child: Text(
                  asProvider.getString('Loading failed!'),
                  style: TextStyle(color: cc.greyHint),
                ),
              );
            }
            return Consumer<SearchResultDataService>(
                builder: (context, pcService, child) {
              return newMethod(cardWidth, cardHeight, pcService.searchResult);
            });
          },
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  Widget newMethod(double cardWidth, double cardHeight, List<dynamic> data) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          // 'No data has been found!',
          asProvider.getString('No product found'),
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: GridView.builder(
              controller: controller,
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.only(left: 20, top: 15, bottom: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: cardWidth / cardHeight,
                crossAxisSpacing: 12,
                // mainAxisSpacing: 12
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final e = data[index];
                return ProductCard(
                    e.prdId,
                    e.title,
                    e.price,
                    e.discountPrice,
                    e.campaignPercentage.toDouble(),
                    e.imgUrl,
                    e.isCartAble,
                    e.badge);
              },
            ),
          ),
          Consumer<SearchResultDataService>(
            builder: (context, srService, child) {
              return srService.isLoading
                  ? loadingProgressBar()
                  : const SizedBox();
            },
          )
        ],
      );
    }
  }

  scrollListener(BuildContext context) {
    if (controller.offset >= controller.position.maxScrollExtent &&
        controller.position.outOfRange) {
      if (Provider.of<SearchResultDataService>(context, listen: false)
          .isLoading) {
        return;
      }
      if (Provider.of<SearchResultDataService>(context, listen: false)
          .lastPage) {
        snackBar(context, asProvider.getString('No more product found!'),
            backgroundColor: cc.orange);
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
