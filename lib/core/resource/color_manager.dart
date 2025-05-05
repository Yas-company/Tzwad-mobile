import 'package:flutter/material.dart';

class ColorManager {
  static const Color colorPrimary = Color(0xff00B106);
  static const Color colorLightPrimary = Color(0xffE3FFE5);
  static const Color colorLightPrimary2 = Color(0xffBAEDBF);
  static const Color colorLightPrimary3 = Color(0xffDDEFDE);

  static const Color colorSecondary = Color(0XFFFF960A);

  static const Color colorDisable = Color(0X7F1CC9BC);

  static const Color colorBackground = Color(0XFFFFFFFF);

  static const Color colorTitleTexts = Color(0xff333333);

  // White
  static const Color colorPureWhite = Color(0xffFFFFFF);
  static const Color colorGreyDots = Color(0xffD8D8D8);

  // Color Grey
  static const Color colorGrey1 = Color(0XFFB8B8B8);

  static const genericBoxShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 10,
    offset: Offset(0, 2),
    spreadRadius: 0,
  );

  static BoxShadow customShadow(double blurRadius) {
    return BoxShadow(
      color: const Color(0x14000000),
      blurRadius: blurRadius,
      offset: const Offset(0, 2),
      spreadRadius: 0,
    );
  }

  // static const MaterialColor primarySwatch = MaterialColor(
  //   0xFFffffff,
  //   <int, Color>{
  //     50: Color(0xFFffffff),
  //     100: Color(0xFFffffff),
  //     200: Color(0xFFffffff),
  //     300: Color(0xFFffffff),
  //     400: Color(0xFFffffff),
  //     500: Color(0xFFffffff),
  //     600: Color(0xFFffffff),
  //     700: Color(0xFFffffff),
  //     800: Color(0xFFffffff),
  //     900: Color(0xFFffffff),
  //   },
  // );
}
