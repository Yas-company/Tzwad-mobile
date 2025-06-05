import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/providers/order_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'cart_state.dart';

class CartController extends AutoDisposeNotifier<CartState> {
  @override
  CartState build() {
    state = _onInit();
    getCart();
    return state;
  }

  CartState _onInit() => CartState();

  void getCart() async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      getProductsDataState: DataState.loading,
    );
    final result = await repository.getCart();
    result.fold(
      (l) => state = state.copyWith(
        getProductsDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.isEmpty) {
          state = state.copyWith(
            getProductsDataState: DataState.empty,
            products: [],
          );
        } else {
          state = state.copyWith(
            getProductsDataState: DataState.success,
            products: r,
          );
        }
      },
    );
  }

  void updateQuantityForProduct(ProductModel product, int quantity) async {
    final repository = ref.read(productRepositoryProvider);
    product.isLoading = true;
    state = state.copyWith(
      products: state.products
          .map(
            (e) => e.id == product.id ? product : e,
          )
          .toList(),
    );
    final result = await repository.updateProductQuantity(
      id: product.id!,
      quantity: quantity,
    );
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
        product.cartQuantity = quantity;
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

  void removeProductFromCart(ProductModel product) async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      removeFromCartDataState: DataState.loading,
    );
    final result = await repository.removeProductFromCart(
      id: product.id!,
    );
    result.fold(
      (l) => state = state.copyWith(
        removeFromCartDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        final items = List<ProductModel>.from(state.products)..remove(product);
        if (items.isEmpty) {
          state = state.copyWith(
            removeFromCartDataState: DataState.success,
            getProductsDataState: DataState.empty,
            products: [],
          );
        } else {
          state = state.copyWith(
            removeFromCartDataState: DataState.success,
            getProductsDataState: DataState.success,
            products: items,
          );
        }
      },
    );
  }

  void checkout() async {
    final repository = ref.read(orderRepositoryProvider);
    state = state.copyWith(
      checkoutDataState: DataState.loading,
    );
    final result = await repository.checkout(
      supplierId: 1,
      notes: 'notes notes',
    );
    result.fold(
      (l) => state = state.copyWith(
        checkoutDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        state = state.copyWith(
          checkoutDataState: DataState.success,
          getProductsDataState: DataState.empty,
          products: [],
        );
      },
    );
  }
}
