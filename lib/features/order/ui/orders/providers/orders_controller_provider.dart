import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/order/ui/orders/controller/orders_controller.dart';
import 'package:tzwad_mobile/features/order/ui/orders/controller/orders_state.dart';

final ordersControllerProvider = NotifierProvider.autoDispose<OrdersController, OrdersState>(
  () {
    return OrdersController();
  },
);
