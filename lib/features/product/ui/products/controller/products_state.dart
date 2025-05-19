import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ProductsState {
  final DataState getProductsDataState;
  final List<ProductModel> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  ProductsState({
    this.getProductsDataState = DataState.initial,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
  });

  ProductsState copyWith({
    DataState? getProductsDataState,
    List<ProductModel>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
  }) {
    return ProductsState(
      getProductsDataState: getProductsDataState ?? this.getProductsDataState,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }
}
