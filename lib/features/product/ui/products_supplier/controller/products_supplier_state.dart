import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ProductsSupplierState<T> {
  final DataState getProductsSupplierDataState;
  final bool isLoadingMore;
  final List<T> productsSupplier;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;
  final DataState deleteProductDataState;

  ProductsSupplierState({
    this.getProductsSupplierDataState = DataState.initial,
    this.isLoadingMore = false,
    this.productsSupplier = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
    this.deleteProductDataState = DataState.initial,
  });

  ProductsSupplierState<T> copyWith({
    DataState? getProductsSupplierDataState,
    bool? isLoadingMore,
    List<T>? productsSupplier,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
    DataState? deleteProductDataState,
  }) {
    return ProductsSupplierState<T>(
      getProductsSupplierDataState: getProductsSupplierDataState ?? this.getProductsSupplierDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      productsSupplier: productsSupplier ?? this.productsSupplier,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
      deleteProductDataState: deleteProductDataState ?? this.deleteProductDataState,
    );
  }
}
