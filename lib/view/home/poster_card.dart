import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../service/language_service.dart';
import '../../service/navigation_bar_helper_service.dart';
import '../../service/search_result_data_service.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';
import 'all_camp_product_from_link.dart';
import 'category_product_page.dart';

class PosterCard extends StatelessWidget {
  final String title;
  final String btText;
  final String description;
  final String image;
  final bool showButton;
  int? capm;
  int? cat;

  PosterCard(
      this.title, this.btText, this.description, this.image, this.showButton,
      {this.capm, this.cat});

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return
        // Container(
        //   // padding: const EdgeInsets.only(left: 20, top: 25),
        //   height: 15,
        //   width: 320,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //   ),
        //   child: Stack(
        //     children: [
        //       ClipRRect(
        //         borderRadius: BorderRadius.circular(20),
        //         child: SizedBox(
        //           height: double.infinity,
        //           width: 320,
        //           child: Image.network(
        //             image,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        Container(
      // margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.only(left: 20, right: 20),
      // height: 15,
      width: screenWidth / 5,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          // begin: Alignment.topLeft,
          // end: Alignment.bottomRight,
          stops: [.6, 1],
          colors: [
            // Color.fromARGB(242, 220, 255, 222),
            Color(0xffDCFFDE),
            Color.fromARGB(107, 220, 255, 222),
          ],
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/elements.png'),
          alignment: Provider.of<LanguageService>(context, listen: false).rtl
              ? Alignment.bottomLeft
              : Alignment.bottomRight,
        ),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenWidth / 2.5,
              child: Text(
                title,
                style: TextStyle(
                  color: cc.blackColor,
                  fontSize: screenWidth / 25,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
                width: screenWidth / 3,
                child: Padding(
                  padding: EdgeInsets.only(
                    left:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 0,
                    right:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 0,
                  ),
                  child: Text(
                    description,
                    style: TextStyle(
                      color: cc.greyParagraph,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 3,
                  ),
                )),
            if (showButton) const SizedBox(height: 10),
            if (showButton)
              ElevatedButton(
                onPressed: () {
                  if (capm != null) {
                    Navigator.of(context).pushNamed(
                        ALLCampProductFromLink.routeName,
                        arguments: [capm.toString(), title]);
                  }
                  if (cat != null) {
                    Provider.of<SearchResultDataService>(context, listen: false)
                        .setCategoryId(cat.toString(), notListen: true);
                    Navigator.of(context)
                        .pushNamed(CategoryProductPage.routeName, arguments: [
                      cat.toString(),
                      title
                    ]).then((value) => Provider.of<SearchResultDataService>(
                                context,
                                listen: false)
                            .resetSerchFilters());
                  }
                },
                child: FittedBox(
                  child: SizedBox(
                      width: screenWidth / 4,
                      child: Center(
                        child: Text(
                          btText,
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      )),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    backgroundColor: cc.primaryColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            // const Spacer()
          ],
        ),
        const Spacer(),
        // Stack(
        //   children: [
        // Container(
        //   margin: EdgeInsets.only(
        //       right:
        //           Provider.of<LanguageService>(context, listen: false).rtl
        //               ? 0
        //               : 3,
        //       left: Provider.of<LanguageService>(context, listen: false).rtl
        //           ? 3
        //           : 0,
        //       bottom: 2),
        //   child: SizedBox(
        //     // height: screenHight / 7,
        //     width: screenWidth / 3,
        //     child: Image.asset('assets/images/elements.png'),
        //   ),
        // ),
        Container(
          margin: EdgeInsets.only(
              right: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 0
                  : 3,
              left: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 3
                  : 0,
              bottom: 2),
          width: screenWidth / 3.5,
          child: Image.network(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const SizedBox(),
          ),
        ),
        //   ],
        // ),
      ]),
      //     ),
      //   ],
      // ),
    );
  }
}
