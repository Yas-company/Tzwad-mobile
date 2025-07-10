import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';

class SearchBackRow extends StatelessWidget {
  const SearchBackRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: ColorManager.colorWhite3),
                  borderRadius:
                  BorderRadius.circular(8)),
              child: const Image(
                  image: AssetImage(
                      "assets/icons/ic_arrow.png")),
            ),
            const SizedBox(
              width: AppPadding.p8,
            ),
            Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Text(
                  "المنتجات",
                  style: StyleManager.getBoldStyle(
                      color: Colors.white,
                      fontSize: FontSize.s18),
                ),
                Text(
                  "منتجات الألبان",
                  style: StyleManager.getRegularStyle(
                      color: ColorManager.colorWhite3,
                      fontSize: FontSize.s14),
                ),
              ],
            )
          ],
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8)),
          child: const Image(
              image: AssetImage(
                  "assets/icons/ic_search.png")),
        )
      ],
    );
  }
}