import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ProductDetailsState {
  final DataState getProductDetailsDataState;
  final ProductModel? product;
  final int quantity;
  final double totalPrice;
  final Failure? failure;

  ProductDetailsState({
    this.getProductDetailsDataState = DataState.initial,
    this.product,
    this.quantity = 1,
    this.totalPrice = 0.0,
    this.failure,
  });

  ProductDetailsState copyWith({
    DataState? getProductDetailsDataState,
    ProductModel? product,
    int? quantity,
    double? totalPrice,
    Failure? failure,
  }) {
    return ProductDetailsState(
      getProductDetailsDataState: getProductDetailsDataState ?? this.getProductDetailsDataState,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      failure: failure ?? this.failure,
    );
  }
}
