import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

import 'item_product.dart';

class ProductHorizontalListContent extends StatelessWidget {
  const ProductHorizontalListContent({
    super.key,
    required this.products,
    required this.isLoading,
  });

  final List<ProductModel> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: AppSize.s210,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
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
      ),
    );
  }

  _onPressedFavoriteButton(WidgetRef ref, int productId, bool value) {}

  _onPressedAddToCartButton(WidgetRef ref, ProductModel product) {}
}
