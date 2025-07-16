import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_fields_response_model.dart';

class CategorySupplierState {
  final DataState getProductsByCategoryDataState;
  final bool isLoadingMore;
  final List<SupplierCategories> products;
  final List<SupplierFieldsData> fields;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  // 🔽 Add create category specific state
  final DataState supplierFieldsState;
  final DataState createCategoryState;
  final DataState deleteCategoryState;
  final bool isCategoryCreated;

  CategorySupplierState({
    this.getProductsByCategoryDataState = DataState.initial,
    this.isLoadingMore = false,
    this.products = const [],
    this.fields = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
    this.createCategoryState = DataState.initial,
    this.supplierFieldsState = DataState.initial,
    this.deleteCategoryState = DataState.initial,
    this.isCategoryCreated = false,
  });

  CategorySupplierState copyWith({
    DataState? getProductsByCategoryDataState,
    bool? isLoadingMore,
    List<SupplierCategories>? products,
    List<SupplierFieldsData>? fields,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,

    // 🔽 New fields
    DataState? supplierFieldsState,
    DataState? createCategoryState,
    DataState? deleteCategoryState,
    bool? isCategoryCreated,
  }) {
    return CategorySupplierState(
      getProductsByCategoryDataState: getProductsByCategoryDataState ?? this.getProductsByCategoryDataState,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      fields: fields ?? this.fields,
      failure: failure ?? this.failure,
      supplierFieldsState: supplierFieldsState ?? this.supplierFieldsState,
      createCategoryState: createCategoryState ?? this.createCategoryState,
      deleteCategoryState: deleteCategoryState ?? this.deleteCategoryState,
      isCategoryCreated: isCategoryCreated ?? this.isCategoryCreated,
    );
  }
}

