import 'package:flutter/material.dart';
import 'package:gren_mart/service/country_dropdown_service.dart';
import 'package:gren_mart/service/state_dropdown_service.dart';
import 'package:gren_mart/view/auth/custom_text_field.dart';
import 'package:provider/provider.dart';

import 'constant_name.dart';
import 'constant_styles.dart';

class StateDropdown extends StatelessWidget {
  final hintText;
  final selectedValue;
  final onChanged;
  final textFieldHint;
  final iconColor;
  final textStyle;

  StateDropdown(
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
          Provider.of<StateDropdownService>(context, listen: false)
              .setStateSearchValue('');
          Provider.of<StateDropdownService>(context, listen: false).getStates(
              Provider.of<CountryDropdownService>(context, listen: false)
                  .selectedCountryId);
          controller.addListener(() {
            scrollListener(context);
          });
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                // height: 5 * 30 > screenHight / 2 ? screenHight / 2 : 5 * 30,
                // margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: cc.pureWhite,
                ),
                constraints: BoxConstraints(
                    maxHeight: screenHight / 2 +
                        (MediaQuery.of(context).viewInsets.bottom / 2)),
                child: Consumer<StateDropdownService>(
                    builder: (context, sProvider, child) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: CustomTextField(
                            asProvider.getString(textFieldHint ?? ''),
                            onChanged: (value) {
                          sProvider.setStateSearchValue(value);
                          print("change in textField");
                          sProvider.getStates(
                              Provider.of<CountryDropdownService>(context,
                                      listen: false)
                                  .selectedCountryId);
                        }),
                      ),
                      Expanded(
                        child: ListView.separated(
                            shrinkWrap: true,
                            controller: controller,
                            padding: EdgeInsets.only(
                                right: 20, left: 20, bottom: 20),
                            itemBuilder: (context, index) {
                              if (sProvider.isLoading ||
                                  sProvider.stateDropdownList.length == index &&
                                      sProvider.nexPage != null) {
                                return SizedBox(
                                    height: 50,
                                    width: double.infinity,
                                    child: Center(
                                        child: loadingProgressBar(
                                            size: 30, color: cc.primaryColor)));
                              }
                              if (sProvider.stateDropdownList.isEmpty) {
                                return Text(
                                  asProvider.getString("No result found"),
                                  style: textStyle,
                                );
                              }
                              if (sProvider.stateDropdownList.length == index) {
                                return SizedBox();
                              }

                              final element =
                                  sProvider.stateDropdownList[index];
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
                            itemCount: sProvider.isLoading == true
                                ? 1
                                : sProvider.stateDropdownList.length + 1),
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
    final sProvider = Provider.of<StateDropdownService>(context, listen: false);
    final orderListData = sProvider;

    try {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        if (orderListData.nexPage != null && !sProvider.loadingNextPage) {
          sProvider.getNextStates(context);
        } else {}
      }
    } catch (e) {}
  }
}
