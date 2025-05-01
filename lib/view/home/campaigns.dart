import 'package:flutter/material.dart';
import 'package:gren_mart/view/home/bottom_navigation_bar.dart';
import 'package:gren_mart/view/home/campaign_smaller_card.dart';
import '../../service/product_card_data_service.dart';
import '../../view/utils/app_bars.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import '../utils/constant_name.dart';
import 'all_camp_product_from_link.dart';

class Campaigns extends StatelessWidget {
  static const routeName = 'campaigns page';
  Campaigns({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    final routeData =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final data = routeData[0];
    final title = routeData[1];
    double cardWidth = screenWidth / 3;
    double cardHeight = screenHight / 5.5 < 141 ? 141 : screenHight / 5.5;
    print(cardWidth / cardHeight);
    return Scaffold(
      appBar: AppBars().appBarTitled(context, title, () {
        controller.dispose();
        Navigator.of(context).pop();
      }),
      body: Consumer<ProductCardDataService>(builder: (context, srData, child) {
        return Column(
          children: [
            Expanded(
              child: newMethod(cardWidth, cardHeight, data),
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
        padding: EdgeInsets.only(top: 15, bottom: 30),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: cardWidth / cardHeight,
            // crossAxisSpacing: 3,
            mainAxisSpacing: 12),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final element = data[index];
          // if (srData.resultMeta!.lastPage >= pageNo) {
          return SizedBox(
            height: screenHight / 5 < 155 ? 155 : screenHight / 5,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                    ALLCampProductFromLink.routeName,
                    arguments: [element.id.toString(), element.title]);
              },
              child: CampaignSmallerCard(
                element.title,
                element.subtitle,
                element.image,
                element.endDate.isAfter(DateTime.now())
                    ? element.endDate.difference(DateTime.now())
                    : Duration(seconds: 1),
                margin: false,
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
}
