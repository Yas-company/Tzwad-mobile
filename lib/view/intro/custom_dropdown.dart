import 'package:flutter/material.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';

class CustomDropdown extends StatelessWidget {
  String hintText;
  List listData;
  String? value;
  String? country;
  void Function(Object?)? onChanged;
  CustomDropdown(this.hintText, this.listData, this.onChanged,
      {this.value, Key? key})
      : super(key: key);

  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: ConstantColors().greyBorder,
          width: 1,
        ),
      ),
      child: DropdownButton(
        hint: Text(hintText),
        underline: Container(),
        elevation: 0,
        value: value,
        style: TextStyle(color: cc.greyHint),
        icon: Icon(
          Icons.keyboard_arrow_down_sharp,
          color: ConstantColors().greyHint,
        ),
        onChanged: onChanged,
        items: (listData).map((value) {
          return DropdownMenuItem(
            alignment: Alignment.centerLeft,
            value: value,
            child: SizedBox(
              width: screenWidth - 83,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(value),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
