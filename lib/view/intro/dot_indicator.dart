import 'package:flutter/material.dart';

import '../utils/constant_colors.dart';

class DotIndicator extends StatefulWidget {
  bool isActive;
  DotIndicator(this.isActive);

  @override
  State<DotIndicator> createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isActive ? 12 : 9,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        height: widget.isActive ? 10 : 8.0,
        width: widget.isActive ? 24 : 8.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: widget.isActive
              ? ConstantColors().primaryColor
              : ConstantColors().greyDots,
        ),
      ),
    );
  }
}
