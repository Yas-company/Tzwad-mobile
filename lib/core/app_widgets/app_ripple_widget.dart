import 'package:flutter/material.dart';

class AppRippleWidget extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onLongPress;
  final Widget child;
  final double radius;

  const AppRippleWidget({
    super.key,
    this.onTap,
    this.onLongPress,
    required this.child,
    this.radius = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        radius: radius,
        borderRadius: BorderRadius.all(
          Radius.circular(
            radius,
          ),
        ),
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
