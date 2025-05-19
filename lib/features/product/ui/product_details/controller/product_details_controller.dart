import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/providers/cart_local_data_provider.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'product_details_state.dart';

class ProductDetailsController extends AutoDisposeNotifier<ProductDetailsState> {
  @override
  ProductDetailsState build() {
    state = _onInit();
    return state;
  }

  ProductDetailsState _onInit() => ProductDetailsState();

  void getProduct(int id) async {
    final repository = ref.read(productRepositoryProvider);
    state = state.copyWith(
      getProductDetailsDataState: DataState.loading,
    );
    final result = await repository.getProduct(id: id);
    result.fold(
      (l) => state = state.copyWith(
        getProductDetailsDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        getProductDetailsDataState: DataState.success,
        product: r,
        totalPrice: double.tryParse(r.price ?? '0.0'),
      ),
    );
  }

  void increaseQuantity() {
    if (state.quantity == state.product?.stockQty) return;
    final price = double.tryParse(state.product?.price ?? '0.0') ?? 0.0;
    int quantity = state.quantity + 1;
    state = state.copyWith(
      quantity: quantity,
      totalPrice: price * quantity,
    );
  }

  void decreaseQuantity() {
    if (state.quantity == 1) return;
    final price = double.tryParse(state.product?.price ?? '0.0') ?? 0.0;
    int quantity = state.quantity - 1;

    state = state.copyWith(
      quantity: quantity,
      totalPrice: price * quantity,
    );
  }

  void addProductToCart() {
    final cartLocalData = ref.read(cartLocalDataProvider);
    final product = state.product;
    if (product == null) return;
    product.quantity = state.quantity;
    cartLocalData.increaseProductToCart(product);
  }
}
