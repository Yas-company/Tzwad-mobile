import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_product_model.dart';

import 'item_cart_product.dart';

class CartProductListContent extends HookConsumerWidget {
  const CartProductListContent({
    super.key,
    this.isLoading = false,
    required this.items,
  });

  final bool isLoading;
  final List<CartProductModel> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = useSupplierProductsScrollController(
    //   onLoadMore: onLoadMore,
    // );
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        // controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) => ItemCartProduct(
          product: items[index],
        ),
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) => const Gap(AppPadding.p16),
      ),
    );
  }
}
