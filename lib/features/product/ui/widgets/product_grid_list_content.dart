import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/products/hooks/products_scroll_controller_hook.dart';

import 'item_product.dart';

class ProductGridListContent extends HookConsumerWidget {
  const ProductGridListContent({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.products,
    this.onLoadMore,
    this.onPressedFavoriteButton,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<ProductModel> products;
  final Function()? onLoadMore;
  final Function(int, bool)? onPressedFavoriteButton;
  final Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useProductsScrollController(
      onLoadMore: onLoadMore,
    );
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppPadding.p12,
          mainAxisSpacing: AppPadding.p12,
          childAspectRatio: 0.8,
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= products.length) {
            return Skeletonizer(
              enabled: true,
              child: ItemProduct(
                product: ProductModel.fake(),
                onPressedFavoriteButton: onPressedFavoriteButton ?? (_, __) {},
              ),
            );
          }
          if (failure != null && index == products.length) {
            return Text(
              failure!.message,
            );
          }
          return ItemProduct(
            product: products[index],
            onPressedFavoriteButton: onPressedFavoriteButton ?? (_, __) {},
          );
        },
        itemCount: itemCount,
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? products.length + 4
      : failure != null
          ? products.length + 1
          : products.length;
}
