import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/models/order_type_enum.dart';

class OrdersState {
  final DataState getOrdersDataState;
  final bool isLoadingMore;
  final List<OrderModel> orders;
  final OrderTypeEnum orderType;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  OrdersState({
    this.getOrdersDataState = DataState.initial,
    this.isLoadingMore = false,
    this.orders = const [],
    this.orderType = OrderTypeEnum.all,
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
  });

  OrdersState copyWith({
    DataState? getOrdersDataState,
    bool? isLoadingMore,
    List<OrderModel>? orders,
    OrderTypeEnum? orderType,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
  }) {
    return OrdersState(
      getOrdersDataState: getOrdersDataState ?? this.getOrdersDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      orders: orders ?? this.orders,
      orderType: orderType ?? this.orderType,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }
}
