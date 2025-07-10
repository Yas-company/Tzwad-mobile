import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'products_supplier_state.dart';

class ProductsSupplierController extends AutoDisposeNotifier<ProductsSupplierState> {
  @override
  ProductsSupplierState build() {
    state = _onInit();
    getProductsSupplier();
    return state;
  }

  ProductsSupplierState _onInit() => ProductsSupplierState();

  void getProductsSupplier() async {
    final repository = ref.read(productRepositoryProvider);

    state = state.copyWith(
      getProductsSupplierDataState: DataState.loading,
    );

    final result = await repository.getProductsSupplier();

    result.fold(
          (failure) {
        state = state.copyWith(
          getProductsSupplierDataState: DataState.failure,
          failure: failure,
        );
      },
          (pageModel) {
        final products = pageModel.data;
        final hasMore = pageModel.hasMore;

        if (products.isEmpty) {
          state = state.copyWith(
            getProductsSupplierDataState: DataState.empty,
            productsSupplier: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getProductsSupplierDataState: DataState.success,
            productsSupplier: products,
            hasMore: hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(productRepositoryProvider);
      state = state.copyWith(isLoadingMore: true);

      final result = await repository.getProductsSupplier(page: state.pageNumber);

      result.fold(
            (failure) {
          state = state.copyWith(
            isLoadingMore: false,
            failure: failure,
          );
        },
            (pageModel) {
          final newItems = pageModel.data;
          final items = List<ProductSupplierModel>.from(state.productsSupplier)..addAll(newItems);

          state = state.copyWith(
            isLoadingMore: false,
            productsSupplier: items,
            hasMore: pageModel.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }

  Future<void> deleteProductSupplier(String productId) async {
    final repository = ref.read(productRepositoryProvider);

    state = state.copyWith(
      deleteProductDataState: DataState.loading,
    );

    final result = await repository.removeProductSupplier(id: productId);

    result.fold(
          (failure) {
        state = state.copyWith(
          deleteProductDataState: DataState.failure,
          failure: failure,
        );
      },
          (_) {
        // حذف المنتج محلياً من القائمة لتحديث الـ UI فورًا
        final updatedList = List<ProductSupplierModel>.from(state.productsSupplier)
          ..removeWhere((product) => product.id == productId);

        state = state.copyWith(
          deleteProductDataState: DataState.success,
          productsSupplier: updatedList,
          failure: null,
        );

      },
    );
  }
}
