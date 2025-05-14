import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';

enum AdaptiveEnum { mobile, tablet, desktop }

class AppAdaptiveWidget extends StatelessWidget {
  const AppAdaptiveWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
  });

  final Widget desktop;
  final Widget tablet;
  final Widget mobile;

  @override
  Widget build(BuildContext context) {
    final adaptive = context.getAdaptive();
    switch (adaptive) {
      case AdaptiveEnum.desktop:
        return desktop;
      case AdaptiveEnum.tablet:
        return tablet;
      case AdaptiveEnum.mobile:
        return mobile;
    }
  }
}
