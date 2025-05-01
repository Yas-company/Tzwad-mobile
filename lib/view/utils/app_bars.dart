import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../service/language_service.dart';
import '../../view/utils/constant_colors.dart';

class AppBars {
  ConstantColors cc = ConstantColors();

  PreferredSizeWidget appBarTitled(
      BuildContext context, String? title, Function ontap,
      {bool hasButton = true,
      bool hasElevation = true,
      bool? centerTitle = true,
      List<Widget>? actions}) {
    return AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        elevation: hasElevation ? 1 : 0,
        foregroundColor: cc.blackColor,
        centerTitle: centerTitle,
        title: title == null
            ? null
            : Text(
                title,
                style: TextStyle(
                    color: cc.blackColor, fontWeight: FontWeight.w600),
              ),
        leading: GestureDetector(
          onTap: () => ontap(),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Transform(
              transform:
                  Provider.of<LanguageService>(context, listen: false).rtl
                      ? Matrix4.rotationY(pi)
                      : Matrix4.rotationY(0),
              child: SvgPicture.asset(
                'assets/images/icons/back_button.svg',
                color: cc.blackColor,
                height: 25,
              ),
            ),
          ]),
        ),
        actions: actions);
  }
}
