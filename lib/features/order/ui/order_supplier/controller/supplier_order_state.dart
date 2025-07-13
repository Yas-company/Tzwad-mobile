import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class SupplierOrderState {
  final DataState getProductsByCategoryDataState;
  final bool isLoadingMore;
  final List<SupplierCategories> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  // 🔽 Add create category specific state
  final DataState createCategoryState;
  final DataState deleteCategoryState;
  final bool isCategoryCreated;

  SupplierOrderState({
    this.getProductsByCategoryDataState = DataState.initial,
    this.isLoadingMore = false,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
    this.createCategoryState = DataState.initial,
    this.deleteCategoryState = DataState.initial,
    this.isCategoryCreated = false,
  });

  SupplierOrderState copyWith({
    DataState? getProductsByCategoryDataState,
    bool? isLoadingMore,
    List<SupplierCategories>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,

    // 🔽 New fields
    DataState? createCategoryState,
    DataState? deleteCategoryState,
    bool? isCategoryCreated,
  }) {
    return SupplierOrderState(
      getProductsByCategoryDataState: getProductsByCategoryDataState ?? this.getProductsByCategoryDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
      createCategoryState: createCategoryState ?? this.createCategoryState,
      deleteCategoryState: deleteCategoryState ?? this.deleteCategoryState,
      isCategoryCreated: isCategoryCreated ?? this.isCategoryCreated,
    );
  }
}

