import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';

class SupplierDetailsState {
  final DataState getSupplierCategoriesDataState;
  final DataState getSupplierProductsDataState;
  final List<SupplierCategoryModel> categories;
  final bool isLoadingMore;
  final List<SupplierProductModel> products;
  final int pageNumber;
  final bool hasMore;
  final Failure? supplierCategoriesFailure;
  final Failure? supplierProductsFailure;

  SupplierDetailsState({
    this.getSupplierCategoriesDataState = DataState.initial,
    this.getSupplierProductsDataState = DataState.initial,
    this.categories = const [],
    this.isLoadingMore = false,
    this.products = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.supplierCategoriesFailure,
    this.supplierProductsFailure,
  });

  SupplierDetailsState copyWith({
    DataState? getSupplierCategoriesDataState,
    DataState? getSupplierProductsDataState,
    List<SupplierCategoryModel>? categories,
    bool? isLoadingMore,
    List<SupplierProductModel>? products,
    int? pageNumber,
    bool? hasMore,
    Failure? supplierCategoriesFailure,
    Failure? supplierProductsFailure,
  }) {
    return SupplierDetailsState(
      getSupplierCategoriesDataState: getSupplierCategoriesDataState ?? this.getSupplierCategoriesDataState,
      getSupplierProductsDataState: getSupplierProductsDataState ?? this.getSupplierProductsDataState,
      categories: categories ?? this.categories,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      products: products ?? this.products,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      supplierCategoriesFailure: supplierCategoriesFailure ?? this.supplierCategoriesFailure,
      supplierProductsFailure: supplierProductsFailure ?? this.supplierProductsFailure,
    );
  }
}
