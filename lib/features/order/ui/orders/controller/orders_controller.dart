import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/models/order_type_enum.dart';
import 'package:tzwad_mobile/features/order/providers/order_repository_provider.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'orders_state.dart';

class OrdersController extends AutoDisposeNotifier<OrdersState> {
  @override
  OrdersState build() {
    state = _onInit();
    getOrders();
    return state;
  }

  OrdersState _onInit() => OrdersState();

  void getOrders({OrderTypeEnum orderType = OrderTypeEnum.all}) async {
    final repository = ref.read(orderRepositoryProvider);
    state = state.copyWith(
      getOrdersDataState: DataState.loading,
      orderType: orderType,
    );
    final result = await repository.getOrders(
      page: 1,
      orderType: orderType,
    );
    result.fold(
      (l) => state = state.copyWith(
        getOrdersDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getOrdersDataState: DataState.empty,
            orders: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getOrdersDataState: DataState.success,
            orders: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore) {
      final repository = ref.read(orderRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getOrders(
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ),
        (r) {
          final items = List<OrderModel>.from(state.orders)..addAll(r.data);
          state = state.copyWith(
            isLoadingMore: false,
            orders: items,
            hasMore: r.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }

  void toggleFavorite(int productId, bool value) async {
    final repository = ref.read(productRepositoryProvider);
    if (value) {
      await repository.addProductToFavorites(id: productId);
    } else {
      await repository.removeProductFromFavorites(id: productId);
    }
  }
}
