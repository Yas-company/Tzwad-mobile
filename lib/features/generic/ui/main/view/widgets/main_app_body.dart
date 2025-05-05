import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';

class MainAppBody extends StatelessWidget {
  const MainAppBody({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenWidth = context.getWidth;
    final screenHeight = context.getHeight;

    final isPortrait = mediaQueryData.orientation == Orientation.portrait;
    final isLandscape = !isPortrait;

    final isTablet = ((isPortrait && screenWidth > 600) || (isLandscape && screenHeight > 600));

    const minTextScaleFactor = 1.0;
    const maxTextScaleFactor = 1.2;

    const designSize = Size(427, 925);

    final scaleWidth = screenWidth / designSize.width;
    final scaleHeight = screenHeight / designSize.height;

    double scaleText = min(scaleWidth, scaleHeight);

    // double fontScale = context.isRtl ? fontSize : fontSize * 1.05;
    final phoneScaleFactor = mediaQueryData.textScaler.scale(1).clamp(minTextScaleFactor, maxTextScaleFactor);

    double textScaleFactor = (phoneScaleFactor + scaleText) / 2;
    double devicePixelRatio = mediaQueryData.devicePixelRatio;

    if (isTablet && isPortrait) textScaleFactor = textScaleFactor * 1.08;
    if (isTablet && isLandscape) textScaleFactor = textScaleFactor * 1.16;

    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: TextScaler.linear(textScaleFactor),
        devicePixelRatio: devicePixelRatio,
      ),
      child: child,
    );
  }
}
