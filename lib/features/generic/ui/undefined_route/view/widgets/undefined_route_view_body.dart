import 'package:flutter/material.dart';

class UnDefinedRouteViewBody extends StatelessWidget {
  const UnDefinedRouteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'AppStrings.strNoRouteFound.tr(context)',
          style: TextStyle(
            color: Color(0xFFA0A0A0),
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    );
  }
}
