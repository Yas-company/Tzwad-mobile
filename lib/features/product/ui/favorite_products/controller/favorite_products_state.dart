import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class FavoriteProductsState {
  final DataState getFavoriteProductsDataState;
  final List<ProductModel> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  FavoriteProductsState({
    this.getFavoriteProductsDataState = DataState.initial,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
  });

  FavoriteProductsState copyWith({
    DataState? getFavoriteProductsDataState,
    List<ProductModel>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
  }) {
    return FavoriteProductsState(
      getFavoriteProductsDataState: getFavoriteProductsDataState ?? this.getFavoriteProductsDataState,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }
}

