import 'package:flutter/material.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';

ConstantColors _cc = ConstantColors();

Widget posterSkelleton() {
  return Container(
    padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
    // height: 15,
    width: screenWidth / 5,

    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), color: _cc.pureWhite),
    child: Row(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 7.5,
              color: _cc.greyBorder,
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 8.5,
              color: _cc.greyBorder,
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 8.5,
              color: _cc.greyBorder,
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              width: screenWidth / 8.5,
              color: _cc.greyBorder,
              height: 15,
            ),
            Container(
              height: screenHight / 7,
              width: screenWidth / 3.4,
              color: _cc.greyBorder,
            )
          ],
        )
      ],
    ),
  );
}
