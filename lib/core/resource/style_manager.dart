import 'package:flutter/material.dart';

import 'font_manager.dart';

abstract class StyleManager {
  static TextStyle _getTextStyle(
    double fontSize,
    FontWeight fontWeight,
    color,
  ) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: 1.4,
      // letterSpacing: 0.4,
    );
  }

  static TextStyle getCustomTextStyle({
    required TextStyle basicStyle,
    TextStyle? otherStyle,
  }) {
    return basicStyle;
  }

  static TextStyle getLightStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.light,
      color,
    );
  }

  static TextStyle getRegularStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.regular,
      color,
    );
  }

  static TextStyle getMediumStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.medium,
      color,
    );
  }

  static TextStyle getSemiBoldStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.semiBold,
      color,
    );
  }
  static TextStyle getSemiBoldUnderlineStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.semiBold,
      color,
    ).copyWith(
      decoration: TextDecoration.underline,
    );
  }

  static TextStyle getBoldStyle({
    double fontSize = FontSize.s14,
    required Color color,
  }) {
    return _getTextStyle(
      fontSize,
      FontWeightManager.bold,
      color,
    );
  }
}
