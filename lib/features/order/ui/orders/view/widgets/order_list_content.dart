import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/ui/orders/hooks/orders_scroll_controller_hook.dart';

import 'item_order.dart';

class OrderListContent extends HookConsumerWidget {
  const OrderListContent({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.orders,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<OrderModel> orders;
  final Function()? onLoadMore;
  final Failure? failure;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useOrdersScrollController(
      onLoadMore: onLoadMore,
    );

    return Skeletonizer(
      enabled: isLoading,
      child: ListView.separated(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= orders.length) {
            return Skeletonizer(
              enabled: true,
              child: ItemOrder(
                order: OrderModel.fake(),
              ),
            );
          }
          if (failure != null && index == orders.length) {
            return Text(
              failure?.message ?? '',
            );
          }
          return ItemOrder(
            order: orders[index],
          );
        },
        itemCount: itemCount,
        separatorBuilder: (BuildContext context, int index) => const Gap(AppPadding.p12),
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? orders.length + 2
      : failure != null
          ? orders.length + 1
          : orders.length;
}
