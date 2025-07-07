import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class AppDotIndicatorWidgets extends StatelessWidget {
  const AppDotIndicatorWidgets({
    super.key,
    required this.currentPage,
    required this.index,
    required this.colorFocus,
    required this.colorUnFocus,
  });

  final double currentPage;
  final int index;
  final Color colorFocus;
  final Color colorUnFocus;

  @override
  Widget build(BuildContext context) {
    double distance = (currentPage - index).abs().clamp(0.0, 1.0);
    double width = lerpDouble(AppSize.s10, AppSize.s16, 1 - distance)!;
    Color color = Color.lerp(colorUnFocus, colorFocus, 1 - distance)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: AppSize.s2,
      width: width,
      margin: const EdgeInsets.only(right: AppPadding.p4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s20),
        color: color,
      ),
    );
  }
}
