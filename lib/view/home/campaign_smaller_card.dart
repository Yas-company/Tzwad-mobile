import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_colors.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/text_themes.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';

import '../../service/language_service.dart';

class CampaignSmallerCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String imgUrl;
  final Duration duration;
  bool margin;
  CampaignSmallerCard(this.title, this.subTitle, this.imgUrl, this.duration,
      {this.margin = true, Key? key})
      : super(key: key);
  final cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return Container(
      height: (screenHight / 3.4 < 221 ? 221 : screenHight / 3.4),
      width: screenWidth / 2.5,
      margin: margin
          ? EdgeInsets.only(
              right: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 0
                  : 20,
              left: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 20
                  : 0,
              top: 10)
          : const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: cc.lightPrimery3),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            SizedBox(
              height: (screenHight / 3.4 < 221 ? 221 : screenHight / 3.4),
              width: screenWidth / 2.5,
              child: Image.network(
                imgUrl,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/product_skelleton.png'),
                            opacity: .4)),
                  );
                },
                errorBuilder: (context, error, stackTrace) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/product_skelleton.png'),
                          opacity: .4)),
                ),
                // color: cc.pureWhite.withOpacity(.5),
                // colorBlendMode: BlendMode.luminosity,
              ),
            ),
            Container(
              height: (screenHight / 3.4 < 221 ? 221 : screenHight / 3.4),
              width: screenWidth / 2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      cc.pureWhite.withOpacity(.1),
                      cc.blackColor.withOpacity(.8),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    // stops: [.1, .3, 1],
                    tileMode: TileMode.mirror),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      child: SlideCountdownSeparated(
                    showZeroValue: true,
                    separator: '',
                    decoration: BoxDecoration(
                      color: cc.primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    duration: duration,
                  )),
                  SizedBox(height: 5),
                  FittedBox(
                    child: Text(title,
                        style: TextStyle(
                          color: cc.pureWhite,
                          fontSize: screenWidth / 24,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subTitle,
                    maxLines: 3,
                    style: TextThemeConstrants.paragraphText.copyWith(
                      color: cc.pureWhite.withOpacity(.8),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
