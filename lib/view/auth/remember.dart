import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';

import '../utils/constant_colors.dart';

class RememberBox extends StatelessWidget {
  bool rememberPass = false;
  void Function(bool?)? onChanged;
  RememberBox(this.rememberPass, this.onChanged);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
              // splashRadius: 30,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              side: BorderSide(
                width: 1,
                color: ConstantColors().greyBorder,
              ),
              activeColor: ConstantColors().primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                  side: BorderSide(
                    width: 1,
                    color: ConstantColors().greyBorder,
                  )),
              value: rememberPass,
              onChanged: onChanged),
        ),
        Text(
          asProvider.getString('Remember me'),
          style: TextStyle(
            color: ConstantColors().greyHint,
          ),
        ),
      ],
    );
  }
}
