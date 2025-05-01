import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:provider/provider.dart';

import '../../service/categories_data_service.dart';
import '../../service/language_service.dart';
import '../../service/search_result_data_service.dart';
import '../../view/utils/constant_styles.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initCategories(context);

    MoneyFormatter startRange = MoneyFormatter(
        amount: Provider.of<CategoriesDataService>(context, listen: false)
            .minPrice);
    MoneyFormatter endRange = MoneyFormatter(
        amount: Provider.of<CategoriesDataService>(context, listen: false)
            .maxPrice);

    return Consumer<CategoriesDataService>(builder: (context, catData, chaild) {
      return catData.categorydataList.isEmpty
          ? SizedBox(height: 150, child: Center(child: loadingProgressBar()))
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(
                    left:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 25.0,
                    right:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 25
                            : 0,
                    top: 15),
                child: Text(
                  'Filter by:',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Provider.of<LanguageService>(context, listen: false).rtl
                      ? 0
                      : 25.0,
                  right:
                      Provider.of<LanguageService>(context, listen: false).rtl
                          ? 25
                          : 0,
                ),
                child: textFieldTitle(asProvider.getString('All categories'),
                    fontSize: 13),
              ),
              Container(
                height: 44,
                child: ListView.builder(
                    padding: EdgeInsets.only(
                      left: Provider.of<LanguageService>(context, listen: false)
                              .rtl
                          ? 0
                          : 25.0,
                      right:
                          Provider.of<LanguageService>(context, listen: false)
                                  .rtl
                              ? 25
                              : 0,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: catData.categorydataList.length,
                    itemBuilder: ((context, index) {
                      final e = catData.categorydataList[index];
                      // print(e.title);
                      final isSelected =
                          e.id.toString() == catData.selectedCategorieId;
                      return GestureDetector(
                          onTap: () {
                            if (isSelected) {
                              catData.setSelectedCategory('');
                              catData.setSelectedSubCategory('');
                              return;
                            }
                            catData.setSelectedCategory(e.id.toString());
                          },
                          child: filterOption(e.title, isSelected));
                    })),
              ),
              if (catData.selectedCategorieId.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(
                    left:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 25.0,
                    right:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 25
                            : 0,
                  ),
                  child: textFieldTitle(asProvider.getString('Sub-category'),
                      fontSize: 13),
                ),
              if (catData.selectedCategorieId.isNotEmpty &&
                  (catData.loading || catData.noSubcategory))
                Container(
                  padding: EdgeInsets.only(
                    left:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 25.0,
                    right:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 25
                            : 0,
                  ),
                  child: catData.noSubcategory
                      ? Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            asProvider.getString('No sub-category available'),
                            style: TextStyle(color: cc.greyHint, fontSize: 14),
                          ))
                      : loadingProgressBar(),
                ),
              if (catData.subCategorydataList != null)
                Container(
                  padding: EdgeInsets.only(
                    left:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 0
                            : 25.0,
                    right:
                        Provider.of<LanguageService>(context, listen: false).rtl
                            ? 25
                            : 0,
                  ),
                  height: 44,
                  child: Builder(builder: (context) {
                    return GestureDetector(
                        onTap: () {
                          if (catData.selectedSubCategorieId.isNotEmpty) {
                            catData.setSelectedSubCategory('');
                            return;
                          }
                          catData.setSelectedSubCategory(
                              catData.subCategorydataList!.id.toString());
                        },
                        child: filterOption(catData.subCategorydataList!.title,
                            catData.selectedSubCategorieId.isNotEmpty));
                  }),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textFieldTitle(asProvider.getString('Filter Price'),
                        fontSize: 13),
                    Consumer<SearchResultDataService>(
                        builder: (context, srService, child) {
                      return Container(
                        margin: EdgeInsets.only(
                          left: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 0
                              : 25.0,
                          right: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 25
                              : 0,
                        ),
                        child: Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return Text((lService.currencyRTL
                                  ? ''
                                  : lService.currency) +
                              (srService.minPrice.isNotEmpty
                                  ? MoneyFormatter(
                                          amount:
                                              double.parse(srService.minPrice))
                                      .output
                                      .withoutFractionDigits
                                  : startRange.output.withoutFractionDigits) +
                              (lService.currencyRTL ? lService.currency : '') +
                              '-' +
                              (lService.currencyRTL ? '' : lService.currency) +
                              (srService.maxPrice.isNotEmpty
                                  ? MoneyFormatter(
                                          amount:
                                              double.parse(srService.maxPrice))
                                      .output
                                      .withoutFractionDigits
                                  : endRange.output.withoutFractionDigits) +
                              (lService.currencyRTL ? lService.currency : ''));
                        }),
                      );
                    })
                  ],
                ),
              ),
              Consumer<SearchResultDataService>(
                  builder: (context, srData, child) {
                return RangeSlider(
                  values: RangeValues(
                      srData.minPrice.isEmpty
                          ? Provider.of<CategoriesDataService>(context,
                                  listen: false)
                              .minPrice
                          : double.parse(srData.minPrice),
                      srData.maxPrice.isEmpty
                          ? Provider.of<CategoriesDataService>(context,
                                  listen: false)
                              .maxPrice
                          : double.parse(srData.maxPrice)),
                  max:
                      Provider.of<CategoriesDataService>(context, listen: false)
                          .maxPrice,
                  min:
                      Provider.of<CategoriesDataService>(context, listen: false)
                          .minPrice,

                  // divisions: 5,
                  activeColor: cc.primaryColor,

                  inactiveColor: cc.lightPrimery3,
                  labels: RangeLabels(
                    srData.rangevalue.start.round().toString(),
                    srData.rangevalue.end.round().toString(),
                  ),
                  onChanged: (RangeValues values) {
                    if (values.start >
                            Provider.of<CategoriesDataService>(context,
                                    listen: false)
                                .minPrice ||
                        values.end <
                            Provider.of<CategoriesDataService>(context,
                                    listen: false)
                                .maxPrice) {
                      print(values.end);
                      srData.setRangeValues(values);
                      return;
                    }
                  },
                );
              }),
              Padding(
                padding: EdgeInsets.only(
                  left: Provider.of<LanguageService>(context, listen: false).rtl
                      ? 0
                      : 25.0,
                  right:
                      Provider.of<LanguageService>(context, listen: false).rtl
                          ? 25
                          : 0,
                ),
                child: textFieldTitle(asProvider.getString('Average Rating'),
                    fontSize: 13),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(children: [
                  Consumer<SearchResultDataService>(
                      builder: (context, srData, child) {
                    return RatingBar.builder(
                      itemSize: 24,
                      initialRating: double.parse(srData.ratingPoint),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                      itemBuilder: (context, _) => SvgPicture.asset(
                        'assets/images/icons/star.svg',
                        color: cc.orangeRating,
                      ),
                      onRatingUpdate: (rating) {
                        srData.setRating(rating.toInt());
                        print(rating);
                      },
                    );
                  }),
                  Spacer(),
                  Consumer<SearchResultDataService>(
                    builder: (context, srService, child) {
                      return Container(
                        child: GestureDetector(
                          onTap: () {
                            srService.setRating('0');
                          },
                          child: Icon(
                            Icons.refresh_rounded,
                            color: cc.primaryColor,
                          ),
                        ),
                      );
                    },
                  )
                ]),
              ),
              const SizedBox(height: 40),
              Consumer<SearchResultDataService>(
                  builder: (context, srData, child) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: customRowButton(
                      context,
                      asProvider.getString('Reset Filter'),
                      asProvider.getString('Apply Filter'), () {
                    filterReset(context, srData);
                  }, () {
                    filterApply(context, srData);
                  }),
                );
              }),
              const SizedBox(height: 10),
            ]);
    });
  }

  initCategories(BuildContext context) {
    Provider.of<CategoriesDataService>(context, listen: false)
        .fetchCategories()
        .onError((error, stackTrace) => snackBar(
            context, asProvider.getString('Connection failed'),
            backgroundColor: cc.orange));
  }

  Widget filterOption(String text, bool isSelected) {
    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? cc.primaryColor : cc.greyBorder,
            width: 1,
          ),
          color: isSelected ? cc.lightPrimery3 : null),
      child: FittedBox(
        child: Row(children: [
          Text(text, style: TextStyle(color: cc.greyHint, fontSize: 12)),
          const SizedBox(width: 5),
          SvgPicture.asset(
            isSelected
                ? 'assets/images/icons/selected_circle.svg'
                : 'assets/images/icons/deselected_circle.svg',
          )
        ]),
      ),
    );
  }

  filterApply(BuildContext context, SearchResultDataService srData) {
    srData.setCategoryId(
        Provider.of<CategoriesDataService>(context, listen: false)
            .selectedCategorieId
            .toString());
    srData.setSubCategoryId(
        Provider.of<CategoriesDataService>(context, listen: false)
            .selectedSubCategorieId
            .toString());
    srData.resetSerch();
    srData.fetchProductsBy(pageNo: '1');
    srData.setFilterOn(true);
    if (srData.categoryId == '' &&
        srData.subCategoryId == '' &&
        srData.minPrice == '' &&
        srData.maxPrice == '' &&
        (srData.ratingPoint == '' || srData.ratingPoint == '0')) {
      srData.setFilterOn(false);
    }
    Navigator.of(context).pop();
  }

  void filterReset(BuildContext context, SearchResultDataService srData) {
    Provider.of<CategoriesDataService>(context, listen: false)
        .setSelectedCategory('');
    Provider.of<CategoriesDataService>(context, listen: false)
        .setSelectedSubCategory('');
    srData.resetSerchFilters();
    srData.fetchProductsBy(pageNo: '1');
    Navigator.of(context).pop();
  }
}
