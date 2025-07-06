import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class HomeSupplierState {
  final DataState getProductsDataState;
  final DataState getCategoriesDataState;
  final DataState getAdsDataState;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final List<String> ads;
  final Failure? failure;

  HomeSupplierState({
    this.getProductsDataState = DataState.initial,
    this.getCategoriesDataState = DataState.initial,
    this.getAdsDataState = DataState.initial,
    this.products = const [],
    this.categories = const [],
    this.ads = const [],
    this.failure,
  });

  HomeSupplierState copyWith({
    DataState? getProductsDataState,
    DataState? getCategoriesDataState,
    DataState? getAdsDataState,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    List<String>? ads,
    Failure? failure,
  }) {
    return HomeSupplierState(
      getProductsDataState: getProductsDataState ?? this.getProductsDataState,
      getCategoriesDataState: getCategoriesDataState ?? this.getCategoriesDataState,
      getAdsDataState: getAdsDataState ?? this.getAdsDataState,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      ads: ads ?? this.ads,
      failure: failure ?? this.failure,
    );
  }
}
