import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_state.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/provider/supplier_order_provider.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class SupplierOrderController extends AutoDisposeNotifier<SupplierOrderState> {
  @override
  SupplierOrderState build() {
    state = _onInit();
    return state;
  }

  SupplierOrderState _onInit() => SupplierOrderState();

  void getSupplierOrders() async {
    final repository = ref.read(supplierOrderRepositoryProvider);
    state = state.copyWith(
      getProductsByCategoryDataState: DataState.loading,
    );
    final result = await repository.getSupplierOrders();
    result.fold((l) => state = state.copyWith(
      getProductsByCategoryDataState: DataState.failure,
      failure: l,
    ), (r) {
      if (r.data.isEmpty) {
        state = state.copyWith(
          getProductsByCategoryDataState: DataState.empty,
          products: [],
          hasMore: false,
        );
      } else {
        state = state.copyWith(
          getProductsByCategoryDataState: DataState.success,
          products: r.data,
          hasMore: r.hasMore,
          pageNumber: 2,
        );
      }
    },
    );
  }

  void getMoreData() async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(supplierOrderRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getSupplierOrders(
        page: state.pageNumber,);
      result.fold(
            (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ), (r) {
        final items = List<SupplierCategories>.from(state.products)..addAll(r.data);
        state = state.copyWith(
          isLoadingMore: false,
          products: items,
          hasMore: r.hasMore,
          pageNumber: state.pageNumber + 1,
        );
      },
      );
    }
  }

}


