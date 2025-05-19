import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CartState {
  final DataState getProductsDataState;
  final List<ProductModel> products;
  final Failure? failure;

  CartState({
    this.getProductsDataState = DataState.initial,
    this.products = const [],
    this.failure,
  });

  CartState copyWith({
    DataState? getProductsDataState,
    List<ProductModel>? products,
    Failure? failure,
  }) {
    return CartState(
      getProductsDataState: getProductsDataState ?? this.getProductsDataState,
      products: products ?? this.products,
      failure: failure ?? this.failure,
    );
  }
}
