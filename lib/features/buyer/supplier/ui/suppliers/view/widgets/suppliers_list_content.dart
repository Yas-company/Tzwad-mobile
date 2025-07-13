import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';
import 'package:tzwad_mobile/features/product/ui/products/hooks/products_scroll_controller_hook.dart';

import 'item_grid_supplier.dart';
import 'item_supplier.dart';

class SuppliersListContent extends HookConsumerWidget {
  const SuppliersListContent({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.items,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<SupplierModel> items;
  final Function()? onLoadMore;
  final Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useProductsScrollController(
      onLoadMore: onLoadMore,
    );
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= items.length) {
            return Skeletonizer(
              enabled: true,
              child: ItemSupplier(
                supplier: SupplierModel.fake(),
              ),
            );
          }
          if (failure != null && index == items.length) {
            return Text(
              failure!.message,
            );
          }
          return ItemSupplier(
            supplier: items[index],
          );
        },
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) => const Gap(AppPadding.p12),
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? items.length + 1
      : failure != null
          ? items.length + 1
          : items.length;
}
