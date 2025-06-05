import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';

class OrderDetailsState {
  final DataState getOrderDetailsDataState;
  final OrderModel? order;
  final Failure? failure;

  OrderDetailsState({
    this.getOrderDetailsDataState = DataState.initial,
    this.order,
    this.failure,
  });

  OrderDetailsState copyWith({
    DataState? getOrderDetailsDataState,
    OrderModel? order,
    Failure? failure,
  }) {
    return OrderDetailsState(
      getOrderDetailsDataState: getOrderDetailsDataState ?? this.getOrderDetailsDataState,
      order: order ?? this.order,
      failure: failure ?? this.failure,
    );
  }
}
