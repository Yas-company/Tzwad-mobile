import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/home/ui/providers/home_controller_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ItemProduct extends StatelessWidget {
  const ItemProduct({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.s160,
      height: AppSize.s190,
      // margin: const EdgeInsets.symmetric(
      //   horizontal: AppPadding.p6,
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: ColorManager.borderColor,
        ),
        color: ColorManager.colorPureWhite,
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => _onPressedItemButton(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: ColorManager.whiteGrey,
                    borderRadius: BorderRadius.circular(
                      AppSize.s8,
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: 1.6,
                    child: AppNetworkImageWidget(
                      url: product.image ?? '',
                      radius: AppSize.s8,
                      placeHolderEnum: PlaceHolderEnum.product,
                    ),
                  ),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return AppRippleWidget(
                        onTap: () => _onPressedFavoriteButton(ref),
                        child: Container(
                          padding: const EdgeInsets.all(AppPadding.p4),
                          decoration: const BoxDecoration(
                            color: ColorManager.colorPureWhite,
                            shape: BoxShape.circle,
                            boxShadow: [
                              ColorManager.genericBoxShadow,
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: product.isFavorite ? ColorManager.colorRed : ColorManager.colorGrey1,
                            size: AppSize.s24,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // Title, Price and discount
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? '',
                    style: StyleManager.getSemiBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).marginOnly(
                    bottom: AppPadding.p4,
                  ),
                  Text.rich(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    TextSpan(
                      text: '${product.price} ${Constants.currency} ',
                      style: StyleManager.getSemiBoldStyle(
                        color: ColorManager.colorPrimary,
                        fontSize: FontSize.s12,
                      ),
                      children: [
                        TextSpan(
                          text: '${product.price} ${Constants.currency}',
                          style: StyleManager.getRegularStyle(
                            color: ColorManager.cardGreyHint,
                            fontSize: FontSize.s10,
                          ).copyWith(
                            decoration: TextDecoration.lineThrough,
                            decorationColor: ColorManager.cardGreyHint,
                          ),
                        )
                      ],
                    ),
                  ).marginOnly(
                    bottom: AppPadding.p4,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return AppButtonWidget(
                        label: 'Add to cart',
                        onPressed: () => _onPressedAddToCartButton(ref),
                        buttonSize: ButtonSize.small,
                        buttonType: ButtonType.outline,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onPressedAddToCartButton(WidgetRef ref) {
    ref.read(homeControllerProvider.notifier).addProductToCart(product);
  }

  _onPressedItemButton(BuildContext context) {
    context.pushNamed(
      AppRoutes.productDetailsRoute,
      extra: {
        'id': product.id,
      },
    );
  }

  _onPressedFavoriteButton(WidgetRef ref) {
    ref.read(homeControllerProvider.notifier).switchFavorite(product);
  }
}
