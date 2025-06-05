import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'home_state.dart';

class HomeController extends AutoDisposeNotifier<HomeState> {
  @override
  HomeState build() {
    state = _onInit();
    getProducts();
    getCategories();
    getAds();
    return state;
  }

  HomeState _onInit() => HomeState();

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
      (r) => state = state.copyWith(
        getProductsDataState: DataState.success,
        products: r.data,
      ),
    );
  }

  void getCategories() async {
    final repository = ref.read(categoryRepositoryProvider);
    state = state.copyWith(
      getCategoriesDataState: DataState.loading,
    );
    final result = await repository.getCategories();
    result.fold(
      (l) => state = state.copyWith(
        getCategoriesDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        getCategoriesDataState: DataState.success,
        categories: r.data,
      ),
    );
  }

  void getAds() async {
    // final repository = ref.read(categoryRepositoryProvider);
    state = state.copyWith(
      getAdsDataState: DataState.loading,
    );
    // final result = await repository.getCategories();
    // result.fold(
    //       (l) => state = state.copyWith(
    //         getAdsDataState: DataState.failure,
    //     failure: l,
    //   ),
    //       (r) => state = state.copyWith(
    //         getAdsDataState: DataState.success,
    //     categories: r,
    //   ),
    // );
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

  void toggleFavorite(int productId, bool value) async {
    final repository = ref.read(productRepositoryProvider);
    if (value) {
      await repository.addProductToFavorites(id: productId);
    } else {
      await repository.removeProductFromFavorites(id: productId);
    }
  }
}
