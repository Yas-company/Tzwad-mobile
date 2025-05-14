import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class AppBadgeWidget extends StatelessWidget {
  const AppBadgeWidget({
    super.key,
    required this.child,
    this.label = '',
    this.backgroundColor = ColorManager.colorPrimary,
    this.alignment = AlignmentDirectional.topStart,
    this.smallSize = AppSize.s8,
    this.largeSize = AppSize.s20,
    this.isBadgeVisible = true,
  });

  final String label;
  final Color backgroundColor;
  final AlignmentGeometry alignment;
  final double smallSize;
  final double largeSize;
  final bool isBadgeVisible;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: isBadgeVisible,
      label: label.isNotEmpty ? Text(label) : null,
      smallSize: smallSize,
      largeSize: largeSize,
      padding: label.length == 1 ? const EdgeInsets.symmetric(horizontal: AppPadding.p6) : null,
      backgroundColor: backgroundColor,
      alignment: alignment,
      child: child,
    );
  }
}
