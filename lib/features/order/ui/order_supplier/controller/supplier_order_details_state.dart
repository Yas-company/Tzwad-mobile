import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/features/order/models/supplier_order_details_response_model.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';


class SupplierOrderDetailsState {
  final DataState getSupplierOrderDetailsDataState;
  final SupplierOrder? order;
  final Failure? failure;

  SupplierOrderDetailsState({
    this.getSupplierOrderDetailsDataState = DataState.initial,
    this.order,
    this.failure,
  });

  SupplierOrderDetailsState copyWith({
    DataState? getSupplierOrderDetailsDataState,
    SupplierOrder? order,
    Failure? failure,
  }) {
    return SupplierOrderDetailsState(
      getSupplierOrderDetailsDataState: getSupplierOrderDetailsDataState ?? this.getSupplierOrderDetailsDataState,
      order: order ?? this.order,
      failure: failure ?? this.failure,
    );
  }
}