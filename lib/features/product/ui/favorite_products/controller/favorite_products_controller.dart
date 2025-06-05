import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'favorite_products_state.dart';

class FavoriteProductsController extends AutoDisposeNotifier<FavoriteProductsState> {
  @override
  FavoriteProductsState build() {
    state = _onInit();
    getFavoriteProducts();
    return state;
  }

  FavoriteProductsState _onInit() => FavoriteProductsState();

  void getFavoriteProducts() async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      getFavoriteProductsDataState: DataState.loading,
    );
    final result = await repository.getFavoriteProducts();
    result.fold(
      (l) => state = state.copyWith(
        getFavoriteProductsDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getFavoriteProductsDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getFavoriteProductsDataState: DataState.success,
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
      final result = await repository.getFavoriteProducts(
        page: state.pageNumber,
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

  void toggleFavorite(int productId, bool value) async {
    final repository = ref.read(productRepositoryProvider);
    if (value) {
      await repository.addProductToFavorites(id: productId);
    } else {
      final products = state.products.where((element) => element.id != productId).toList();
      if (products.isEmpty) {
        state = state.copyWith(
          getFavoriteProductsDataState: DataState.empty,
          products: [],
        );
      } else {
        state = state.copyWith(
          products: products,
        );
      }
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
