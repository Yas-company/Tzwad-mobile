import 'dart:ui';

import 'package:flutter/material.dart';

class DottedBorderContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double radius;
  final Color color;

  const DottedBorderContainer({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.radius = 12,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        strokeWidth: strokeWidth,
        radius: radius,
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Color color;

  _DottedBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    const double dashWidth = 5;
    const double dashSpace = 3;
    Path path = Path()..addRRect(rrect);
    PathMetrics pm = path.computeMetrics();
    for (final metric in pm) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        canvas.drawPath(
          metric.extractPath(distance, next),
          paint,
        );
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
