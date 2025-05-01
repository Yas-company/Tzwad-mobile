import 'package:flutter/material.dart';

import '../utils/constant_colors.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const divider(),
        Text(
          'or',
          style: TextStyle(
              color: ConstantColors().greytitle, fontWeight: FontWeight.bold),
        ),
        const divider(),
      ],
    );
  }
}

// ignore: camel_case_types
class divider extends StatelessWidget {
  const divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 15.0, right: 10.0),
        child: const Divider(
          height: 50,
          color: Colors.black,
          thickness: .6,
        ),
      ),
    );
  }
}
