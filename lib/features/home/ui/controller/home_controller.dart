import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/cart_local_data_provider.dart';
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
        categories: r,
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

  void addProductToCart(ProductModel product) {
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.increaseProductToCart(product);
  }

  void switchFavorite(ProductModel product) {
    state = state.copyWith(
      products: state.products.map((e) {
        if (e.id == product.id) {
          e.isFavorite = !e.isFavorite;
        }
        return e;
      }).toList(),
    );
  }
}
