import 'package:flutter/material.dart';

class ColorManager {
  //#
  static const Color colorPrimary3 = Color(0xff5db5b5);
  static const Color colorPrimary = Color(0xff009196);
  static const Color colorPrimary1 = Color(0x42009196);
  static const Color colorSecondary = Color(0XFFF9A51A);
  static const Color colorDisable = Color(0X7F1CC9BC);
  static const Color colorBackground = Color(0XFFFFFFFF);

  // Color Black
  static const Color colorBlack1 = Color(0xff030303); // Primary Text
  static const Color colorBlack2 = Color(0xff7F7F7F); // Secondary Text

  // Color White
  static const Color colorWhite1 = Color(0xffFFFFFF);
  static const Color colorWhite2 = Color(0xff7F7F7F);
  static const Color colorWhite3 = Color(0xffF5F5F5);
  static const Color colorWhite4 = Color(0xffFAFAFA);
  static const Color colorWhite5 = Color(0xffF3F3F3);

  // Color Grey
  // static const Color colorGrey1 = Color(0xffF5F5F5);
  // static const Color colorGrey2 = Color(0xff7F7F7F);

  static const Color colorTitleTexts = Color(0xff333333);

  static const Color colorLightPrimary = Color(0xffE3FFE5);
  static const Color colorLightPrimary2 = Color(0xffBAEDBF);
  static const Color colorLightPrimary3 = Color(0xffDDEFDE);

  // White
  static const Color colorPureWhite = Color(0xffFFFFFF);
  static const Color colorGreyDots = Color(0xffD8D8D8);
  static const Color greyBorder = Color.fromARGB(255, 215, 215, 215);
  static const Color greyBorder2 = Color(0xffEAECF0);
  static const Color orange = Color(0xffFF7325);
  static const Color greyTextFieldLebel = Color.fromARGB(255, 169, 168, 168);
  static const Color greytitle = Color(0xff818181);
  static const Color greyParagraph = Color(0xff666666);
  static const Color greyHint = Color(0xff818181);
  static const Color blackColor = Color(0xff333333);
  static const Color whiteGrey = Color(0xffF9F9F9);
  static const Color cardGreyHint = Color(0xff9F9F9F);
  static const Color borderColor = Color(0xffEAECF0);
  static const Color greyFour = Color(0xff9F9F9F);
  static const Color pink = Color(0xffFF4065);
  static const Color greyYellow = Color(0xffFFE38F);

  static const Color grey = Color(0xFFA0A0A0);
  static const Color blue = Color(0xFF3B82F6);
  static const Color red = Color(0xFFEF4444);
  static const Color green = Color(0xFF10B981);
  static const Color indigo = Color(0xFF6366F1);
  static const Color teal = Color(0xFF14B8A6);
  static const Color rose = Color(0xFFF43F5E);

  // Color Grey
  static const Color colorGrey1 = Color(0XFFB8B8B8);

  static const Color colorRed = Color(0xffff0000);

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
