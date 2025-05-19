import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final products = cartLocalData.getCartProducts();
    state = state.copyWith(
      products: products,
    );
  }

  void increaseProductToCart(ProductModel product) {
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.increaseProductToCart(product);
  }

  void decreaseProductToCart(ProductModel product) {
    final cartLocalData = ref.read(cartLocalDataProvider);
    cartLocalData.decreaseProductToCart(product);
  }
}
