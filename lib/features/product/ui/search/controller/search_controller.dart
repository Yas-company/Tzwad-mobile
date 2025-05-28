import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'search_state.dart';

class SearchController extends AutoDisposeNotifier<SearchState> {
  @override
  SearchState build() {
    state = _onInit();
    getCategories();
    return state;
  }

  SearchState _onInit() => SearchState();

  void filterProducts({
    String? search,
    int? categoryId,
    num? minPrice,
    num? maxPrice,
  }) async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      getFilterProductsDataState: DataState.loading,
      search: search,
      categoryId: categoryId,
      resetCategoryId: categoryId == null,
      minPrice: minPrice,
      resetMinPrice: minPrice == null,
      maxPrice: maxPrice,
      resetMaxPrice: maxPrice == null,
    );
    final result = await repository.filterProducts(
      search: search,
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    result.fold(
      (l) => state = state.copyWith(
        getFilterProductsDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getFilterProductsDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getFilterProductsDataState: DataState.success,
            products: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore) {
      final repository = ref.read(productRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.filterProducts(
        page: state.pageNumber,
        search: state.search,
        categoryId: state.categoryId,
        minPrice: state.minPrice,
        maxPrice: state.maxPrice,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ),
        (r) {
          final items = List<ProductModel>.from(state.products)..addAll(r.data);
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

  void getCategories() async {
    final repository = ref.read(categoryRepositoryProvider);
    final result = await repository.getCategories();
    result.fold(
      (l) {},
      (r) => state = state.copyWith(
        categories: r.data,
      ),
    );
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
