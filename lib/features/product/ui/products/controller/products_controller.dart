import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'products_state.dart';

class ProductsController extends AutoDisposeNotifier<ProductsState> {
  @override
  ProductsState build() {
    state = _onInit();
    getProducts();
    return state;
  }

  ProductsState _onInit() => ProductsState();

  void getProducts() async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      getProductsDataState: DataState.loading,
    );
    final result = await repository.getProducts();
    result.fold(
      (l) => state = state.copyWith(
        getProductsDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getProductsDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getProductsDataState: DataState.success,
            products: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getPage() async {
    if (state.hasMore) {
      final repository = ref.read(productRepositoryProvider);
      state = state.copyWith();
      final result = await repository.getProducts(
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          failure: l,
        ),
        (r) {
          List<ProductModel> newDataList = state.products;
          newDataList.addAll(r.data);
          state = state.copyWith(
            products: newDataList,
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
