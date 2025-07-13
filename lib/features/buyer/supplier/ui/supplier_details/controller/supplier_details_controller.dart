import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/providers/supplier_repository_provider.dart';

import 'supplier_details_state.dart';

class SupplierDetailsController extends AutoDisposeNotifier<SupplierDetailsState> {
  @override
  SupplierDetailsState build() {
    state = _onInit();
    return state;
  }

  SupplierDetailsState _onInit() => SupplierDetailsState();

  void getCategories(int supplierId) async {
    final repository = ref.read(supplierRepositoryProvider);
    state = state.copyWith(
      getSupplierCategoriesDataState: DataState.loading,
    );
    final result = await repository.getCategories(
      supplierId: supplierId,
    );
    result.fold(
      (l) => state = state.copyWith(
        getSupplierCategoriesDataState: DataState.failure,
        supplierCategoriesFailure: l,
      ),
      (r) {
        if (r.isEmpty) {
          state = state.copyWith(
            getSupplierCategoriesDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getSupplierCategoriesDataState: DataState.success,
            categories: r,
          );
        }
      },
    );
  }

  void getProducts(int supplierId) async {
    final repository = ref.read(supplierRepositoryProvider);
    state = state.copyWith(
      getSupplierProductsDataState: DataState.loading,
    );
    final result = await repository.getProducts(
      supplierId: supplierId,
    );
    result.fold(
      (l) => state = state.copyWith(
        getSupplierProductsDataState: DataState.failure,
        supplierProductsFailure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getSupplierProductsDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getSupplierProductsDataState: DataState.success,
            products: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData(int supplierId) async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(supplierRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getProducts(
        supplierId: supplierId,
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          supplierProductsFailure: l,
        ),
        (r) {
          final items = List<SupplierProductModel>.from(state.products)..addAll(r.data);
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
