import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/view/widgets/list_view_feilds.dart';

import '../../../../../../core/app_widgets/app_ripple_widget.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';

class AppBarAddProduct extends StatelessWidget {
  const AppBarAddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppRippleWidget(
          onTap: (){
            context.pop();
          },
          child: Container(
            margin: const EdgeInsets.only(right: AppMargin.m16),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: ColorManager.colorWhite3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Image(image: AssetImage("assets/icons/ic_arrow2.png")),
          ),
        ),
        const SizedBox(width: AppPadding.p8),
        Text(
          "اضافة منتج",
          style: StyleManager.getMediumStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s16,
          ),
        ),
      ],
    );
  }
}


