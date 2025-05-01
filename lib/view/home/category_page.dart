import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/view/home/bottom_navigation_bar.dart';
import '../../service/product_card_data_service.dart';
import '../../service/search_result_data_service.dart';
import '../../view/utils/app_bars.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import '../utils/constant_name.dart';
import '../utils/constant_styles.dart';
import 'category_product_page.dart';

class CategoryPage extends StatelessWidget {
  static const routeName = 'category page';
  CategoryPage({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    final routeData =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final data = routeData[0];
    final title = routeData[1];
    double cardWidth = screenWidth / 3.3;
    double cardHeight = 40;
    controller.addListener((() => scrollListener(context)));
    return Scaffold(
      appBar: AppBars().appBarTitled(context, title, () {
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
        // controller: controller,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, top: 15, right: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: cardWidth / cardHeight,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final element = data[index];
          // if (srData.resultMeta!.lastPage >= pageNo) {
          return GestureDetector(
            onTap: () {
              Provider.of<SearchResultDataService>(context, listen: false)
                  .resetSerch();
              Provider.of<SearchResultDataService>(context, listen: false)
                  .resetSerchFilters();
              Provider.of<SearchResultDataService>(context, listen: false)
                  .setSearchText('');
              Provider.of<SearchResultDataService>(context, listen: false)
                  .setCategoryId(element.id.toString(), notListen: true);
              Navigator.of(context).pushNamed(CategoryProductPage.routeName,
                  arguments: [
                    element.id.toString(),
                    element.title
                  ]).then((value) =>
                  Provider.of<SearchResultDataService>(context, listen: false)
                      .resetSerchFilters());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              constraints: BoxConstraints(maxWidth: 150),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: cc.greyBorder,
                    width: 1,
                  )),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      height: 37,
                      width: 37,
                      imageUrl: element.imageUrl ?? '',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.category),
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),
                  //Title
                  Flexible(
                    child: Text(
                      element.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cc.greyParagraph,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          snackBar(context, value);
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
