import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';

class ProductSupplierState {
  final DataState getProductsByCategoryDataState;
  final bool isLoadingMore;
  final List<SupplierCategories> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  // 🔽 Add create category specific state
  final DataState createCategoryState;
  final bool isCategoryCreated;

  ProductSupplierState({
    this.getProductsByCategoryDataState = DataState.initial,
    this.isLoadingMore = false,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
    this.createCategoryState = DataState.initial,
    this.isCategoryCreated = false,
  });

  ProductSupplierState copyWith({
    DataState? getProductsByCategoryDataState,
    bool? isLoadingMore,
    List<SupplierCategories>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,

    // 🔽 New fields
    DataState? createCategoryState,
    bool? isCategoryCreated,
  }) {
    return ProductSupplierState(
      getProductsByCategoryDataState: getProductsByCategoryDataState ?? this.getProductsByCategoryDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
      createCategoryState: createCategoryState ?? this.createCategoryState,
      isCategoryCreated: isCategoryCreated ?? this.isCategoryCreated,
    );
  }
}

