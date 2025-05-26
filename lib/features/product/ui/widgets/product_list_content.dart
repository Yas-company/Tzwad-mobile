import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

import 'item_product.dart';

class ProductListContent extends HookConsumerWidget {
  const ProductListContent({
    super.key,
    required this.products,
    this.onPressedFavoriteButton,
    this.isLoading = false,
    this.onLoadMore,
  });

  final List<ProductModel> products;
  final bool isLoading;
  final Function()? onLoadMore;
  final Function(int, bool)? onPressedFavoriteButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = useProductsScrollController(
    //   ref: ref,
    // );
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        // controller: controller,
        // physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppPadding.p12,
          mainAxisSpacing: AppPadding.p12,
          childAspectRatio: 0.8,
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) => ItemProduct(
          product: products[index],
          onPressedFavoriteButton: onPressedFavoriteButton ?? (_, __) {},
        ),
        itemCount: products.length,
      ),
    );
  }
}
