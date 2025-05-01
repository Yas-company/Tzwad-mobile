import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';
import '../../service/search_result_data_service.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import 'all_camp_product_from_link.dart';
import 'category_product_page.dart';

class CampaignCard extends StatelessWidget {
  final String title;
  final String btText;
  final String image;
  final bool showButton;
  int? camp;
  int? cat;

  CampaignCard(this.title, this.btText, this.image, this.showButton,
      {this.camp, this.cat});

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return Container(
      margin: EdgeInsets.only(
        right:
            Provider.of<LanguageService>(context, listen: false).rtl ? 0 : 20,
        left: Provider.of<LanguageService>(context, listen: false).rtl ? 20 : 0,
      ),
      padding: EdgeInsets.only(
          left:
              Provider.of<LanguageService>(context, listen: false).rtl ? 0 : 20,
          right:
              Provider.of<LanguageService>(context, listen: false).rtl ? 20 : 0,
          top: 25),
      height: 160,
      width: screenWidth / 1.3 < 300 ? 300 : screenWidth / 1.3,
      // color: Color.fromARGB(110, 9, 154, 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cc.lightPrimery2,
      ),

      child: Stack(children: [
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: screenWidth / 4.5,
                    child: FittedBox(
                      child: Text(
                        asProvider.getString('Deal of the Day'),
                        style: TextStyle(
                          color: cc.orange,
                          fontSize: screenWidth / 27,
                          // fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        // maxLines: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: screenWidth / 3,
                    child: SafeArea(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: cc.blackColor,
                          fontSize: screenWidth / 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (showButton) const SizedBox(height: 10),
                  if (showButton)
                    ElevatedButton(
                      onPressed: () {
                        if (camp != null) {
                          Navigator.of(context).pushNamed(
                              ALLCampProductFromLink.routeName,
                              arguments: [camp.toString(), title]);
                        }
                        if (cat != null) {
                          Provider.of<SearchResultDataService>(context,
                                  listen: false)
                              .setCategoryId(cat.toString(), notListen: true);
                          Navigator.of(context).pushNamed(
                              CategoryProductPage.routeName,
                              arguments: [
                                cat.toString(),
                                title
                              ]).then((value) =>
                              Provider.of<SearchResultDataService>(context,
                                      listen: false)
                                  .resetSerchFilters());
                        }
                      },
                      child: FittedBox(
                        child: SizedBox(
                            width: screenWidth / 5,
                            child: Text(
                              btText,
                              textAlign: TextAlign.center,
                              style: TextStyle(overflow: TextOverflow.ellipsis),
                            )),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 21,
                            vertical: 11,
                          ),
                          backgroundColor: cc.orange,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  const Spacer()
                ],
              ),
              const Spacer(),
              Container(
                  // height: screenHight / 7,
                  width: screenHight / 6.5,
                  margin: EdgeInsets.only(
                      right:
                          Provider.of<LanguageService>(context, listen: false)
                                  .rtl
                              ? 0
                              : 3,
                      left: Provider.of<LanguageService>(context, listen: false)
                              .rtl
                          ? 3
                          : 0,
                      bottom: 2),
                  child: Image.network(
                    image,
                    // fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const SizedBox(),
                  )),
            ]),
        // Positioned(
        //   right: 0,
        //   bottom: 0,
        //   child:
        // ),
      ]),
    );
  }
}
