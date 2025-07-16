import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';

class AppDropdownWidget<T> extends StatelessWidget {
  const AppDropdownWidget({
    super.key,
    required this.hintText,
    required this.itemsValues,
    required this.onChanged,
    this.value,
    this.fillColor,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.errorText = '',
    this.helperText,
    this.enabled = true,
    this.itemToString,
  });

  final String hintText;
  final List<T> itemsValues;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Color? fillColor;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String errorText;
  final String? helperText;
  final bool enabled;
  final String Function(T)? itemToString;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = fillColor ?? ColorManager.colorWhite3;
    final TextStyle itemTextStyle = StyleManager.getRegularStyle(
      color: ColorManager.colorWhite2,
      fontSize: FontSize.s14,
    ).copyWith(letterSpacing: 1.5);

    final TextStyle selectedItemTextStyle = StyleManager.getMediumStyle(
      color: ColorManager.colorBlack1,
      fontSize: FontSize.s16,
    ).copyWith(letterSpacing: 1.5);

    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: backgroundColor, // لون قائمة العناصر
      ),
      child: DropdownButtonFormField<T>(
        value: value,
        items: itemsValues.map((e) {
          return DropdownMenuItem<T>(
            value: e,
            child: Text(
              itemToString?.call(e) ?? e.toString(),
              style: itemTextStyle,
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        style: selectedItemTextStyle, // ستايل العنصر المختار
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: StyleManager.getRegularStyle(
            color: ColorManager.colorGrey1,
            fontSize: FontSize.s16,
          ).copyWith(letterSpacing: 1.5),
          fillColor: backgroundColor,
          filled: true,
          prefixIcon: prefixIcon,
          prefix: prefix,
          suffixIcon: suffixIcon,
          suffix: suffix,
          helperText: helperText,
          errorText: errorText.isEmpty ? null : errorText,
          errorMaxLines: 3,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }
}
