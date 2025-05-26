import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class SearchState {
  final DataState getFilterProductsDataState;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final int pageNumber;
  final bool hasMore;
  final String? search;
  final int? categoryId;
  final num? minPrice;
  final num? maxPrice;
  final Failure? failure;

  SearchState({
    this.getFilterProductsDataState = DataState.initial,
    this.products = const [],
    this.categories = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.search,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.failure,
  });

  SearchState copyWith({
    DataState? getFilterProductsDataState,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    int? pageNumber,
    bool? hasMore,
    String? search,
    int? categoryId,
    bool resetCategoryId = false,
    num? minPrice,
    bool resetMinPrice = false,
    num? maxPrice,
    bool resetMaxPrice = false,
    Failure? failure,
  }) {
    return SearchState(
      getFilterProductsDataState: getFilterProductsDataState ?? this.getFilterProductsDataState,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      search: search ?? this.search,
      categoryId: resetCategoryId ? null : (categoryId ?? this.categoryId),
      minPrice: resetMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: resetMaxPrice ? null : (maxPrice ?? this.maxPrice),
      failure: failure ?? this.failure,
    );
  }
}
