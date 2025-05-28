import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class CategoryDetailsState {
  final DataState getProductsByCategoryDataState;
  final bool isLoadingMore;
  final List<ProductModel> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  CategoryDetailsState({
    this.getProductsByCategoryDataState = DataState.initial,
    this.isLoadingMore = false,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
  });

  CategoryDetailsState copyWith({
    DataState? getProductsByCategoryDataState,
    bool? isLoadingMore,
    List<ProductModel>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
  }) {
    return CategoryDetailsState(
      getProductsByCategoryDataState: getProductsByCategoryDataState ?? this.getProductsByCategoryDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }
}
