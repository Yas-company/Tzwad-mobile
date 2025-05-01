import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/service/categories_data_service.dart';
import 'package:gren_mart/service/language_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import 'section_title.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.cc,
    required this.width,
    required this.marginRight,
  }) : super(key: key);
  final ConstantColors cc;

  final double width;
  final double marginRight;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesDataService>(
      builder: (context, provider, child) => provider
              .categorydataList.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle(
                  cc: cc,
                  title: asProvider.getString('Categories'),
                  pressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute<void>(
                    //     builder: (BuildContext context) =>
                    //         const AllCategoriesPage(),
                    //   ),
                    // );
                  },
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 58,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    children: [
                      for (int i = 0; i < provider.categorydataList.length; i++)
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         CampaignByCategoryPage(
                            //       categoryId: provider.categoryList[i].id,
                            //       categoryName:
                            //           provider.categoryList[i].title,
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width,
                            margin: EdgeInsets.only(
                              right: !(Provider.of<LanguageService>(context,
                                          listen: false)
                                      .rtl)
                                  ? marginRight
                                  : 0,
                              left: !(Provider.of<LanguageService>(context,
                                          listen: false)
                                      .rtl)
                                  ? 0
                                  : marginRight,
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(color: cc.borderColor),
                                borderRadius: BorderRadius.circular(9)),
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 13,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                      height: 37,
                                      width: 37,
                                      imageUrl:
                                          provider.categorydataList[i].image ??
                                              '',
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),
                                  //Title
                                  Flexible(
                                    child: Text(
                                      provider.categorydataList[i].title,
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
                          ),
                        )
                    ],
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
