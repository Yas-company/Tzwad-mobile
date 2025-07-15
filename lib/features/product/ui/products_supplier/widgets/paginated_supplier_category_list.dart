import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/ui/products/hooks/products_scroll_controller_hook.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/widgets/loading_supplier_category.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/widgets/supplier_category_item.dart';

class PaginatedSupplierCategoryList extends HookConsumerWidget {
  const PaginatedSupplierCategoryList({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.products,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<SupplierCategories> products;
  final Function()? onLoadMore;
  final Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useProductsScrollController(
      onLoadMore: onLoadMore,
    );
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= products.length) {
            return const Skeletonizer(
              enabled: true,
              child:LoadingSupplierCategory(),
            );
          }
          if (failure != null && index == products.length) {
            return Text(
              failure!.message,
            );
          }
          return SupplierCategoryItem(category: products[index],ref:ref,);
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
