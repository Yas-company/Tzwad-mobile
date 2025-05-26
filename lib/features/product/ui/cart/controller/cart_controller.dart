import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/cart_local_data_provider.dart';
import 'cart_state.dart';

class CartController extends AutoDisposeNotifier<CartState> {
  @override
  CartState build() {
    state = _onInit();
    getProducts();
    return state;
  }

  CartState _onInit() => CartState();

  void getProducts() async {
    final cartLocalData = ref.read(cartLocalDataProvider);
    state = state.copyWith(
      getProductsDataState: DataState.loading,
    );
    final products = cartLocalData.getCartProducts();
    if (products.isEmpty) {
      state = state.copyWith(
        getProductsDataState: DataState.empty,
        products: [],
      );
    } else {
      state = state.copyWith(
        getProductsDataState: DataState.success,
        products: products,
      );
    }
  }

  void increaseProductToCart(ProductModel product) {
    if (product.quantity == product.stockQty) return;
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.increaseProductToCart(product);
    state = state.copyWith(
      products: state.products.map((e) => e.id == product.id ? product : e).toList(),
    );
  }

  void decreaseProductToCart(ProductModel product) {
    if (product.quantity == 1) return;
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.decreaseProductToCart(product);
    state = state.copyWith(
      products: state.products.map((e) => e.id == product.id ? product : e).toList(),
    );
  }

  void removeProductToCart(ProductModel product) {
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.removeProductToCart(product);
    final products = state.products.where((element) => element.id != product.id).toList();
    if (products.isEmpty) {
      state = state.copyWith(
        getProductsDataState: DataState.empty,
        products: products,
      );
    } else {
      state = state.copyWith(
        products: products,
      );
    }
  }
}
