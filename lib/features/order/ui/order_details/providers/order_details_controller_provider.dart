import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/controller/order_details_controller.dart';
import 'package:tzwad_mobile/features/order/ui/order_details/controller/order_details_state.dart';

final orderDetailsControllerProvider = NotifierProvider.autoDispose<OrderDetailsController, OrderDetailsState>(
  () {
    return OrderDetailsController();
  },
);
