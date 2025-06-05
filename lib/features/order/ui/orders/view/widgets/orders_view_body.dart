import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/ui/orders/providers/orders_controller_provider.dart';

import 'order_list_content.dart';
import 'orders_filter_section.dart';

class OrdersViewBody extends ConsumerWidget {
  const OrdersViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        const OrdersFilterSection(),
        Expanded(
          child: getContent(ref),
        ),
      ],
    );
  }

  Widget getContent(
    WidgetRef ref,
  ) {
    final state = ref.watch(
      ordersControllerProvider.select(
        (state) => state.getOrdersDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      ordersControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );

    final orders = ref.watch(
      ordersControllerProvider.select(
        (state) => state.orders,
      ),
    );
    final failure = ref.read(
      ordersControllerProvider.select(
        (state) => state.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return OrderListContent(
          orders: OrderModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return OrderListContent(
          isLoadingMore: isLoadingMore,
          orders: orders,
          failure: failure,
          onLoadMore: () => _onLoadMore(ref),
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'No orders found.',
          ),
        );
      case DataState.failure:
        return Center(
          child: AppFailureWidget(
            failure: failure,
          ),
        );
      default:
        return const SizedBox();
    }
  }

  _onLoadMore(WidgetRef ref) {
    ref.read(ordersControllerProvider.notifier).getMoreData();
  }
}
