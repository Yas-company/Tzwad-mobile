import 'package:flutter/material.dart';
import 'package:gren_mart/service/country_dropdown_service.dart';
import 'package:gren_mart/view/auth/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'constant_name.dart';
import 'constant_styles.dart';

class CountryDropdown extends StatelessWidget {
  final hintText;
  final selectedValue;
  final onChanged;
  final textFieldHint;
  final iconColor;
  final textStyle;

  CountryDropdown(
      {this.hintText,
      this.selectedValue,
      this.onChanged,
      this.textFieldHint,
      this.iconColor,
      this.textStyle,
      Key? key})
      : super(key: key);

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Provider.of<CountryDropdownService>(context, listen: false)
              .setCountrySearchValue('');
          Provider.of<CountryDropdownService>(context, listen: false)
              .getContries(context);
          controller.addListener(() {
            scrollListener(context);
          });
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            // constraints: BoxConstraints(minHeight: screenHight),
            builder: (context) {
              return Container(
                // height: 500,
                // margin: EdgeInsets.all(20),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: cc.pureWhite,
                ),

                constraints: BoxConstraints(
                    maxHeight: screenHight / 2 +
                        (MediaQuery.of(context).viewInsets.bottom / 2)),
                child: Consumer<CountryDropdownService>(
                    builder: (context, cProvider, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomTextField(
                            asProvider.getString(textFieldHint ?? ''),
                            onChanged: (value) {
                          cProvider.setCountrySearchValue(value);
                          print("change in textField");
                          cProvider.getContries(context);
                        }),
                      ),
                      Expanded(
                        child: ListView.separated(
                            controller: controller,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                right: 20, left: 20, bottom: 20),
                            itemBuilder: (context, index) {
                              if (cProvider.countryLoading ||
                                  (cProvider.countryDropdownList.length ==
                                          index &&
                                      cProvider.nexPage != null)) {
                                return SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Center(
                                        child: loadingProgressBar(
                                            size: 30, color: cc.primaryColor)));
                              }
                              if (cProvider.countryDropdownList.isEmpty) {
                                return SizedBox(
                                  width: screenWidth - 60,
                                  child: Center(
                                    child: Text(
                                      asProvider.getString("No result found"),
                                      style: textStyle,
                                    ),
                                  ),
                                );
                              }
                              if (cProvider.countryDropdownList.length ==
                                  index) {
                                return SizedBox();
                              }
                              final element =
                                  cProvider.countryDropdownList[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  if (onChanged == null ||
                                      element == selectedValue) {
                                    return;
                                  }
                                  onChanged(element);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 14),
                                  child: Text(
                                    element,
                                    style: textStyle,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 8,
                                  child: Center(child: Divider()),
                                ),
                            itemCount: cProvider.countryLoading == true
                                ? 1
                                : cProvider.countryDropdownList.length + 1),
                      )
                    ],
                  );
                }),
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: cc.greyBorder,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue ?? hintText ?? '',
                style: textStyle,
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: iconColor,
              )
            ],
          ),
        ));
  }

  scrollListener(BuildContext context) {
    final cProvider =
        Provider.of<CountryDropdownService>(context, listen: false);
    final orderListData = cProvider;

    try {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        if (orderListData.nexPage != null && !cProvider.loadingNextPage) {
          cProvider.getNextPageContries(context);
        } else {}
      }
    } catch (e) {}
  }
}
