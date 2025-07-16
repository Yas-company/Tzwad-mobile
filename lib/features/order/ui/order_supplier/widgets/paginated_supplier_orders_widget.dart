import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/widgets/loading_supplier_category.dart';
import 'package:tzwad_mobile/features/order/models/supplier_orders_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/supplier_order_widget.dart';
import 'package:tzwad_mobile/features/product/ui/products/hooks/products_scroll_controller_hook.dart';

class PaginatedSupplierOrdersWidget extends HookConsumerWidget {
  const PaginatedSupplierOrdersWidget({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.orders,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<SupplierOrdersData> orders;
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
          if (isLoadingMore && index >= orders.length) {
            return const Skeletonizer(
              enabled: true,
              child:LoadingSupplierCategory(),
            );
          }
          if (failure != null && index == orders.length) {
            return Text(
              failure!.message,
            );
          }
          return SupplierOrderWidget(order: orders[index]);
        },
        itemCount: itemCount,
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? orders.length + 4
      : failure != null
      ? orders.length + 1
      : orders.length;
}
