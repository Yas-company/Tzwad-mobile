import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/hooks/supplier_products_scroll_controller_hook.dart';

import 'item_supplier_product.dart';

class SupplierProductsListContent extends HookConsumerWidget {
  const SupplierProductsListContent({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.items,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<SupplierProductModel> items;
  final Function()? onLoadMore;
  final Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useSupplierProductsScrollController(
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
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= items.length) {
            return Skeletonizer(
              enabled: true,
              child: ItemSupplierProduct(
                product: SupplierProductModel.fake(),
              ),
            );
          }
          if (failure != null && index == items.length) {
            return Text(
              failure!.message,
            );
          }
          return ItemSupplierProduct(
            product: items[index],
          );
        },
        itemCount: itemCount,
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? items.length + 4
      : failure != null
      ? items.length + 1
      : items.length;
}
