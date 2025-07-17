import 'package:flutter/material.dart';

class AppDashedBorderContainerWidget extends StatelessWidget {
  final Color borderColor;
  final BorderRadius borderRadius;
  final Widget? child;

  const AppDashedBorderContainerWidget({
    super.key,
    required this.borderColor,
    required this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        borderRadius: borderRadius,
        borderColor: borderColor,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color borderColor;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    required this.borderRadius,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 5, dashSpace = 5;
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    var rect = Offset.zero & size;
    var rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    var path = Path()..addRRect(rrect);
    var pathMetrics = path.computeMetrics();

    for (var metric in pathMetrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final extractPath = metric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
