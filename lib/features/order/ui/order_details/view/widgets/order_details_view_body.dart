import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/providers/order_details_controller_provider.dart';

import 'order_details_content.dart';

class OrderDetailsViewBody extends ConsumerWidget {
  const OrderDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      orderDetailsControllerProvider.select(
        (value) => value.getOrderDetailsDataState,
      ),
    );

    final failure = ref.watch(
      orderDetailsControllerProvider.select(
        (value) => value.failure,
      ),
    );

    final order = ref.watch(
      orderDetailsControllerProvider.select(
        (value) => value.order,
      ),
    );
    switch (state) {
      case DataState.loading:
        return OrderDetailsContent(
          order: OrderModel.fake(),
          isLoading: true,
        );

      case DataState.success:
        return OrderDetailsContent(
          order: order,
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
}
