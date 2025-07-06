import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/home/ui/home_buyer/providers/home_buyer_controller_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/item_product.dart';

class HomeProductListContent extends StatelessWidget {
  const HomeProductListContent({
    super.key,
    required this.products,
    this.isLoading = false,
  });

  final List<ProductModel> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Products',
                style: StyleManager.getSemiBoldStyle(
                  color: ColorManager.greyFour,
                  fontSize: FontSize.s18,
                ),
              ),
              AppRippleWidget(
                onTap: () => _onPressedSeeAllButton(context),
                child: Text(
                  'See All',
                  style: StyleManager.getSemiBoldStyle(
                    color: ColorManager.colorPrimary,
                    fontSize: FontSize.s14,
                  ),
                ),
              ),
            ],
          ).marginOnly(
            start: AppPadding.p16,
            end: AppPadding.p16,
            bottom: AppPadding.p16,
          ),
          SizedBox(
            height: AppSize.s210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16,
              ),
              itemBuilder: (context, index) => Consumer(
                builder: (context, ref, child) {
                  return ItemProduct(
                    product: products[index],
                    onPressedFavoriteButton: (productId, value) => _onPressedFavoriteButton(ref, productId, value),
                    onPressedAddToCartButton: (product) => _onPressedAddToCartButton(ref, product),
                  );
                },
              ),
              itemCount: products.length,
              separatorBuilder: (BuildContext context, int index) => const Gap(AppPadding.p12),
            ),
          )
        ],
      ),
    );
  }

  _onPressedSeeAllButton(BuildContext context) {
    context.pushNamed(AppRoutes.productsRoute);
  }

  _onPressedFavoriteButton(WidgetRef ref, int productId, bool value) {
    ref.read(homeBuyerControllerProvider.notifier).toggleFavorite(productId, value);
  }

  _onPressedAddToCartButton(WidgetRef ref, ProductModel product) {
    ref.read(homeBuyerControllerProvider.notifier).addProductToCart(product);
  }
}
