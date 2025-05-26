import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppImageAssetWidget(
            imagePath: AssetsManager.imgCartEmpty,
            width: AppSize.s200,
            height: AppSize.s200,
          ),
          // Container(
          //   height: 200,
          //   padding: const EdgeInsets.all(20),
          //   child: Image.asset('assets/images/empty_cart.png'),
          // ),
          Text(
            'Add item to cart!',
            style: StyleManager.getRegularStyle(
              color: ColorManager.greyHint,
            ),
          ),
        ],
      ),
    );
  }
}
