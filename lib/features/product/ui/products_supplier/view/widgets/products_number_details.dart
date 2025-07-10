import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import '../../../../../../core/resource/font_manager.dart';

class ProductsNumberDetails extends StatelessWidget {
  const ProductsNumberDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "المنتجات المتبقية",
              style: StyleManager.getRegularStyle(
                  color: ColorManager.colorWhite3, fontSize: FontSize.s14),
            ),
            Text(
              "90",
              style: StyleManager.getBoldStyle(
                  color: ColorManager.colorPureWhite, fontSize: FontSize.s20),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "منتجات على وشك الانتهاء",
              style: StyleManager.getRegularStyle(
                  color: ColorManager.colorWhite3, fontSize: FontSize.s14),
            ),
            Text(
              "90",
              style: StyleManager.getBoldStyle(
                  color: ColorManager.colorPureWhite, fontSize: FontSize.s20),
            ),
          ],
        ),
      ],
    );
  }
}
