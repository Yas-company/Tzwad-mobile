import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget marginAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget marginOnly({double top = 0, double start = 0, double bottom = 0, double end = 0}) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        top: top,
        start: start,
        bottom: bottom,
        end: end,
      ),
      child: this,
    );
  }

  Widget marginSymmetric({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }
}
