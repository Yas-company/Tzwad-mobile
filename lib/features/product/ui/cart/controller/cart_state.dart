import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CartState {
  final DataState getProductsDataState;
  final DataState checkoutDataState;
  final DataState removeFromCartDataState;
  final List<ProductModel> products;
  final Failure? failure;

  CartState({
    this.getProductsDataState = DataState.initial,
    this.checkoutDataState = DataState.initial,
    this.removeFromCartDataState = DataState.initial,
    this.products = const [],
    this.failure,
  });

  CartState copyWith({
    DataState? getProductsDataState,
    DataState? checkoutDataState,
    DataState? removeFromCartDataState,
    List<ProductModel>? products,
    Failure? failure,
  }) {
    return CartState(
      getProductsDataState: getProductsDataState ?? this.getProductsDataState,
      checkoutDataState: checkoutDataState ?? this.checkoutDataState,
      removeFromCartDataState: removeFromCartDataState ?? this.removeFromCartDataState,
      products: products ?? this.products,
      failure: failure ?? this.failure,
    );
  }
}
