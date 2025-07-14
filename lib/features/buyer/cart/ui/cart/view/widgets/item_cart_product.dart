import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_product_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/ui/cart/providers/cart_controller_provider.dart';

class ItemCartProduct extends StatelessWidget {
  const ItemCartProduct({
    super.key,
    required this.product,
  });

  final CartProductModel product;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSize.s80,
          height: AppSize.s80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.s8),
            color: ColorManager.colorWhite3,
          ),
          alignment: Alignment.center,
          child:  AppNetworkImageWidget(
            url: product.productImage ?? '',
            width: AppSize.s60,
            height: AppSize.s60,
            radius: AppSize.s8,
          ),
        ).marginOnly(
          end: AppPadding.p8,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.productName ?? '',
                style: StyleManager.getRegularStyle(
                  color: ColorManager.colorBlack1,
                  fontSize: FontSize.s16,
                ),
              ).marginOnly(bottom: AppPadding.p4),
              Text(
                product.price ?? '',
                style: StyleManager.getMediumStyle(
                  color: ColorManager.colorBlack2,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: ColorManager.colorWhite1,
            borderRadius: BorderRadius.circular(AppSize.s8),
            border: Border.all(
              color: ColorManager.colorWhite3,
            ),
          ),
          child: Consumer(
            builder: (context, ref, child) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () => _onPressedAddButton(ref),
                    icon: const Icon(
                      Icons.add,
                      color: ColorManager.colorWhite2,
                    ),
                  ),
                  Text(
                    product.quantity.toString(),
                    style: StyleManager.getRegularStyle(
                      color: ColorManager.colorBlack1,
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onPressedRemoveButton(ref),
                    icon: const Icon(
                      Icons.remove,
                      color: ColorManager.colorWhite2,
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }

  _onPressedAddButton(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).addQuantity(product);
  }

  _onPressedRemoveButton(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).removeProduct(product);
  }
}
