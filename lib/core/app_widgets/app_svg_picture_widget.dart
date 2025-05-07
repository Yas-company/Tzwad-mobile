import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';

class AppSvgPictureWidget extends StatelessWidget {
  const AppSvgPictureWidget({
    super.key,
    required this.assetName,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.contain,
    this.isTakeRtl = false,
  });

  final String assetName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final bool isTakeRtl;

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..scale(
          (isTakeRtl && !context.isRtl) ? -1.0 : 1.0,
          1.0,
        ),
      child: SvgPicture.asset(
        assetName,
        height: height,
        width: width,
        fit: fit,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      ),
    );
  }
}
