import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ProductDetailsState {
  final DataState getProductDetailsDataState;
  final DataState getProductsRelatedDataState;
  final DataState addProductToCartDataState;
  final ProductModel? product;
  final List<ProductModel> productsRelated;
  final int quantity;
  final double totalPrice;
  final Failure? failure;

  ProductDetailsState({
    this.getProductDetailsDataState = DataState.initial,
    this.getProductsRelatedDataState = DataState.initial,
    this.addProductToCartDataState = DataState.initial,
    this.product,
    this.productsRelated = const [],
    this.quantity = 1,
    this.totalPrice = 0.0,
    this.failure,
  });

  ProductDetailsState copyWith({
    DataState? getProductDetailsDataState,
    DataState? getProductsRelatedDataState,
    DataState? addProductToCartDataState,
    ProductModel? product,
    List<ProductModel>? productsRelated,
    int? quantity,
    double? totalPrice,
    Failure? failure,
  }) {
    return ProductDetailsState(
      getProductDetailsDataState: getProductDetailsDataState ?? this.getProductDetailsDataState,
      getProductsRelatedDataState: getProductsRelatedDataState ?? this.getProductsRelatedDataState,
      addProductToCartDataState: addProductToCartDataState ?? this.addProductToCartDataState,
      product: product ?? this.product,
      productsRelated: productsRelated ?? this.productsRelated,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
      failure: failure ?? this.failure,
    );
  }
}
