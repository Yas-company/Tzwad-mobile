import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'category_details_state.dart';

class CategoryDetailsController extends AutoDisposeNotifier<CategoryDetailsState> {
  @override
  CategoryDetailsState build() {
    state = _onInit();
    return state;
  }

  CategoryDetailsState _onInit() => CategoryDetailsState();

  void getProductsByCategory(int categoryId) async {
    final repository = ref.read(categoryRepositoryProvider);
    state = state.copyWith(
      getProductsByCategoryDataState: DataState.loading,
    );
    final result = await repository.getProductsByCategory(categoryId: categoryId);
    result.fold(
      (l) => state = state.copyWith(
        getProductsByCategoryDataState: DataState.failure,
        failure: l,
      ),
      (r) {
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

  void getMoreData(int categoryId) async {
    if (state.hasMore) {
      final repository = ref.read(categoryRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getProductsByCategory(
        page: state.pageNumber,
        categoryId: categoryId,
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

  void getPage(int categoryId) async {
    if (state.hasMore) {
      final repository = ref.read(categoryRepositoryProvider);
      state = state.copyWith();
      final result = await repository.getProductsByCategory(
        categoryId: categoryId,
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

  void addProductToCart(ProductModel product) async {
    final repository = ref.read(productRepositoryProvider);
    product.isLoading = true;
    state = state.copyWith(
      products: state.products
          .map(
            (e) => e.id == product.id ? product : e,
          )
          .toList(),
    );
    final result = await repository.addProductToCart(id: product.id!);
    result.fold(
      (l) {
        product.isLoading = false;
        state = state.copyWith(
          products: state.products
              .map(
                (e) => e.id == product.id ? product : e,
              )
              .toList(),
        );
      },
      (r) {
        product.isLoading = false;
        product.cartQuantity = (product.cartQuantity ?? 0) + 1;
        state = state.copyWith(
          products: state.products
              .map(
                (e) => e.id == product.id ? product : e,
              )
              .toList(),
        );
      },
    );
  }
}
