import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/providers/supplier_repository_provider.dart';

import 'suppliers_state.dart';

class SuppliersController extends AutoDisposeNotifier<SuppliersState> {
  @override
  SuppliersState build() {
    state = _onInit();
    getSuppliers();
    return state;
  }

  SuppliersState _onInit() => SuppliersState();

  void getSuppliers() async {
    final repository = ref.read(supplierRepositoryProvider);
    state = state.copyWith(
      getSuppliersDataState: DataState.loading,
    );
    final result = await repository.getSuppliers();
    result.fold(
      (l) => state = state.copyWith(
        getSuppliersDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getSuppliersDataState: DataState.empty,
            suppliers: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getSuppliersDataState: DataState.success,
            suppliers: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(supplierRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getSuppliers(
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ),
        (r) {
          final items = List<SupplierModel>.from(state.suppliers)..addAll(r.data);
          state = state.copyWith(
            isLoadingMore: false,
            suppliers: items,
            hasMore: r.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }

  void toggleView(bool isGridView) {
    state = state.copyWith(
      isGridView: isGridView,
    );
  }
}
