import 'package:flutter/material.dart';
import '../../service/product_card_data_service.dart';
import '../../view/utils/app_bars.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import '../utils/constant_name.dart';
import '../utils/constant_styles.dart';
import 'bottom_navigation_bar.dart';
import 'product_card.dart';

class AllProducts extends StatelessWidget {
  static const routeName = 'all product screen';
  AllProducts({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();

  ScrollController controller = ScrollController();
  bool doPop = false;

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    final routeData =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final data = routeData[0];
    final title = routeData[1];
    doPop = routeData.length == 3;
    double cardWidth = screenWidth / 3.3;
    double cardHeight = screenHight / 5.4 < 144 ? 130 : screenHight / 5.4;
    // controller.addListener((() => scrollListener(context)));
    return Scaffold(
      appBar: AppBars().appBarTitled(
          context, title ?? asProvider.getString('All Products'), () {
        controller.dispose();
        Navigator.of(context).pop();
      }),
      body: Consumer<ProductCardDataService>(builder: (context, srData, child) {
        return Column(
          children: [
            Expanded(
              child: data != null
                  ? newMethod(cardWidth, cardHeight, data)
                  : Center(
                      child: Text(
                        asProvider.getString('Something went wrong!'),
                        style: TextStyle(color: cc.greyHint),
                      ),
                    ),
            ),
            // if (srData.featuredCardProductsList.isEmpty) loadingProgressBar()
          ],
        );
      }),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  Widget newMethod(double cardWidth, double cardHeight, List<dynamic> data) {
    if (data.isEmpty) {
      return Center(
        child: Text(
          // 'No data has been found!',
          '',
          style: TextStyle(color: cc.greyHint),
        ),
      );
    } else {
      return GridView.builder(
        controller: controller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, top: 15),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: cardWidth / cardHeight,
          crossAxisSpacing: 12,
          // mainAxisSpacing: 12
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final e = data[index];
          // if (srData.resultMeta!.lastPage >= pageNo) {
          return ProductCard(
            e.prdId,
            e.title,
            e.price,
            e.discountPrice,
            e.campaignPercentage.toDouble(),
            e.imgUrl,
            e.isCartAble,
            e.badge,
            popProductList: doPop,
          );
          // }
          // else {
          //   return const Center(
          //     child: Text('No more product fonund'),
          //   );
          // }
          // else if (srData.resultMeta!.lastPage > pageNo) {
          //   return const Center(
          //       child: Text('No more product available!'));
          // }
        },
      );
    }
  }

  scrollListener(BuildContext context) {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      snackBar(context, asProvider.getString('No more product found!'),
          backgroundColor: cc.orange);
      // print(Provider.of<SearchResultDataService>(context, listen: false)
      //     .pageNumber
      //     .toString);
      // Provider.of<SearchResultDataService>(context, listen: false)
      //     .setIsLoading(true);

      // Provider.of<SearchResultDataService>(context, listen: false)
      //     .fetchProductsBy(
      //         pageNo:
      //             Provider.of<SearchResultDataService>(context, listen: false)
      //                 .pageNumber
      //                 .toString())
      //     .then((value) {
      //   if (value != null) {
      //     snackBar(context, value);
      //   }
      // });
      // Provider.of<SearchResultDataService>(context, listen: false).nextPage();
    }
  }

  Future<bool> showTimout() async {
    await Future.delayed(const Duration(seconds: 10));
    return true;
  }
}
