import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';

class HorizontalDividerSection extends StatelessWidget {
  const HorizontalDividerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _divider(),
        Text(
          'or',
          style: StyleManager.getBoldStyle(
            color: ColorManager.greytitle,
          ),
        ),
        _divider(),
      ],
    );
  }

  Widget _divider() {
    return Expanded(
      child: Container(
        margin: const EdgeInsetsDirectional.only(
          start: 15.0,
          end: 10.0,
        ),
        child: const Divider(
          color: Colors.black,
          thickness: .6,
        ),
      ),
    );
  }
}
