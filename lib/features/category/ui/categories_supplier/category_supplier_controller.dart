import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/category_supplier_state.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class CategorySupplierController extends AutoDisposeNotifier<CategorySupplierState> {
  @override
  CategorySupplierState build() {
    state = _onInit();
    return state;
  }

  CategorySupplierState _onInit() => CategorySupplierState();

  void getSupplierCategory() async {
    final repository = ref.read(categorySupplierRepositoryProvider);
    state = state.copyWith(
      getProductsByCategoryDataState: DataState.loading,
    );
    final result = await repository.getSupplierCategories();
    result.fold((l) => state = state.copyWith(
        getProductsByCategoryDataState: DataState.failure,
        failure: l,
      ), (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getProductsByCategoryDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getProductsByCategoryDataState: DataState.success,
            products: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(categorySupplierRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getSupplierCategories(
        page: state.pageNumber,);
      result.fold(
            (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ), (r) {
          final items = List<SupplierCategories>.from(state.products)..addAll(r.data);
          state = state.copyWith(
            isLoadingMore: false,
            products: items,
            hasMore: r.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }





  Future<void> addSupplierCategory(AddSupplierCategoryRequestModel request) async {
    final repository = ref.read(categorySupplierRepositoryProvider);
    state = state.copyWith(createCategoryState: DataState.loading);
    final result = await repository.createCategory(request);
    result.fold((failure) {
        state = state.copyWith(
          createCategoryState: DataState.failure,
          failure: failure,
          isCategoryCreated: false,
        );
      }, (r) {
        state = state.copyWith(
          createCategoryState: DataState.success,
          isCategoryCreated: true,
        );
      },
    );
  }

  Future<void> updateSupplierCategory(int id,AddSupplierCategoryRequestModel request) async {
    final repository = ref.read(categorySupplierRepositoryProvider);
    state = state.copyWith(createCategoryState: DataState.loading);
    final result = await repository.updateSupplierCategory(id,request);
    result.fold((failure) {
      state = state.copyWith(
        createCategoryState: DataState.failure,
        failure: failure,
        isCategoryCreated: false,
      );
    }, (r) {
      state = state.copyWith(
        createCategoryState: DataState.success,
        isCategoryCreated: true,
      );
    },
    );
  }

  Future<void> deleteSupplierCategory(int id) async {
    final repository = ref.read(categorySupplierRepositoryProvider);
    state = state.copyWith(deleteCategoryState: DataState.loading);
    final result = await repository.deleteSupplierCategory(id);
    result.fold((failure) {
      state = state.copyWith(
        deleteCategoryState: DataState.failure,
        failure: failure,
        isCategoryCreated: false,
      );
    }, (r) {
      state = state.copyWith(
        deleteCategoryState: DataState.success,
        isCategoryCreated: true,
      );
    },
    );
  }


  void getSupplierFields() async {
    final repository = ref.read(categorySupplierRepositoryProvider);
    state = state.copyWith(
      supplierFieldsState: DataState.loading,
    );
    final result = await repository.getSupplierFields();
    result.fold((l) => state = state.copyWith(
      supplierFieldsState: DataState.failure,
      failure: l,
    ), (r) {
      if (r.isEmpty) {
        state = state.copyWith(
          supplierFieldsState: DataState.empty,
          products: [],
          hasMore: false,
        );
      } else {
        state = state.copyWith(
          supplierFieldsState: DataState.success,
          fields: r
        );
      }
    },
    );
  }
}


