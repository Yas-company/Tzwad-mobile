import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/providers/order_repository_provider.dart';
import 'order_details_state.dart';

class OrderDetailsController extends AutoDisposeNotifier<OrderDetailsState> {
  @override
  OrderDetailsState build() {
    state = _onInit();
    return state;
  }

  OrderDetailsState _onInit() => OrderDetailsState();

  void getOrder(int id) async {
    final repository = ref.read(orderRepositoryProvider);
    state = state.copyWith(
      getOrderDetailsDataState: DataState.loading,
    );
    final result = await repository.getOrder(id: id);
    result.fold(
      (l) => state = state.copyWith(
        getOrderDetailsDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        getOrderDetailsDataState: DataState.success,
        order: r,
      ),
    );
  }
}
