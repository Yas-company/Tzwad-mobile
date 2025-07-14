import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_product_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/providers/cart_repository_provider.dart';

import 'cart_state.dart';

class CartController extends AutoDisposeNotifier<CartState> {
  @override
  CartState build() {
    state = _onInit();
    getCartInfo();
    return state;
  }

  CartState _onInit() => CartState();

  void getCartInfo() async {
    final repository = ref.read(cartRepositoryProvider);
    state = state.copyWith(
      getCartInfoDataState: DataState.loading,
    );
    final result = await repository.getCart();
    result.fold(
      (l) => state = state.copyWith(
        getCartInfoDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r == null || (r.cart?.products ?? []).isEmpty) {
          state = state.copyWith(
            getCartInfoDataState: DataState.empty,
          );
        } else {
          state = state.copyWith(
            getCartInfoDataState: DataState.success,
            cartInfo: r,
          );
        }
      },
    );
  }

  void addQuantity(CartProductModel product) async {
    final repository = ref.read(cartRepositoryProvider);
    final result = await repository.addToCart(
      productId: product.id!,
      quantity: (product.quantity ?? 0) + 1,
    );
    result.fold(
      (l) => state = state.copyWith(
        // getCartInfoDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        getCartInfo();
        // product.quantity = (product.quantity ?? 0) + 1;
        // final products = state.cartInfo?.cart?.products
        //     ?.map(
        //       (e) => e.id == product.id ? product : e,
        // )
        //     .toList();
        // state = state.copyWith(
        //   getCartInfoDataState: DataState.success,
        // );
      },
    );
  }

  void removeProduct(CartProductModel product) async {
    final repository = ref.read(cartRepositoryProvider);
    if ((product.quantity ?? 0) == 1) {
      final result = await repository.removeFromCart(
        productId: product.id!,
      );
      result.fold(
        (l) => state = state.copyWith(
          // getCartInfoDataState: DataState.failure,
          failure: l,
        ),
        (r) {
          getCartInfo();
          // state = state.copyWith(
          //   getCartInfoDataState: DataState.empty,
          //   cartInfo: null,
          // );
        },
      );
    } else {
      final result = await repository.addToCart(
        productId: product.id!,
        quantity: (product.quantity ?? 0) - 1,
      );
      result.fold(
        (l) => state = state.copyWith(
          // getCartInfoDataState: DataState.failure,
          failure: l,
        ),
        (r) {
          getCartInfo();
          // product.quantity = (product.quantity ?? 0) - 1;
          // final products = state.cartInfo?.cart?.products
          //     ?.map(
          //       (e) => e.id == product.id ? product : e,
          //     )
          //     .toList();
          // state = state.copyWith(
          //   getCartInfoDataState: DataState.success,
          // );
        },
      );
    }
  }
}
