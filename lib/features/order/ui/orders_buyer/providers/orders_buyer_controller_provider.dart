import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/order/ui/orders_buyer/controller/orders_buyer_controller.dart';
import 'package:tzwad_mobile/features/order/ui/orders_buyer/controller/orders_buyer_state.dart';

final ordersBuyerControllerProvider = NotifierProvider.autoDispose<OrdersBuyerController, OrdersBuyerState>(
  () {
    return OrdersBuyerController();
  },
);
