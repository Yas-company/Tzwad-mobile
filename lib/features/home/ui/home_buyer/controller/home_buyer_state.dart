import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/ads/models/ads_model.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/supplier/models/supplier_model.dart';

class HomeBuyerState {
  final DataState getProductsDataState;
  final DataState getCategoriesDataState;
  final DataState getAdsDataState;
  final DataState getSuppliersDataState;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final List<AdsModel> ads;
  final List<SupplierModel> suppliers;
  final Failure? failure;

  HomeBuyerState({
    this.getProductsDataState = DataState.initial,
    this.getCategoriesDataState = DataState.initial,
    this.getAdsDataState = DataState.initial,
    this.getSuppliersDataState = DataState.initial,
    this.products = const [],
    this.categories = const [],
    this.ads = const [],
    this.suppliers = const [],
    this.failure,
  });

  HomeBuyerState copyWith({
    DataState? getProductsDataState,
    DataState? getCategoriesDataState,
    DataState? getAdsDataState,
    DataState? getSuppliersDataState,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    List<AdsModel>? ads,
    List<SupplierModel>? suppliers,
    Failure? failure,
  }) {
    return HomeBuyerState(
      getProductsDataState: getProductsDataState ?? this.getProductsDataState,
      getCategoriesDataState: getCategoriesDataState ?? this.getCategoriesDataState,
      getAdsDataState: getAdsDataState ?? this.getAdsDataState,
      getSuppliersDataState: getSuppliersDataState ?? this.getSuppliersDataState,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      ads: ads ?? this.ads,
      suppliers: suppliers ?? this.suppliers,
      failure: failure ?? this.failure,
    );
  }
}
