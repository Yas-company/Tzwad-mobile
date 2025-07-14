import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import '../../../../../../core/resource/font_manager.dart';

class ProductsNumberDetails extends StatelessWidget {
  const ProductsNumberDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:14),
      child: Row(
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
          const Spacer(),
          Container(margin:const EdgeInsets.only(bottom:10),
            color:ColorManager.greyBorder2.withOpacity(0.4),
            height:30,width:1,),
          const Spacer(),
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
      ),
    );
  }
}
