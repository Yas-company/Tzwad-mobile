import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/product_supplier_state.dart';

class ProductSupplierController extends AutoDisposeNotifier<ProductSupplierState> {
  @override
  ProductSupplierState build() {
    state = _onInit();
    return state;
  }

  ProductSupplierState _onInit() => ProductSupplierState();

  void getSupplierCategory() async {
    final repository = ref.read(productSupplierRepositoryProvider);
    state = state.copyWith(
      getProductsByCategoryDataState: DataState.loading,
    );
    final result = await repository.getSupplierCategories();
    result.fold((l) {
      state = state.copyWith(
        getProductsByCategoryDataState: DataState.failure,
        failure: l,
      );
      print('lllllll>'+l.toString());
    },(r) {
      print('rrrrrrr>'+r.toString());
        if (r.isEmpty) {
          state = state.copyWith(
            getProductsByCategoryDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getProductsByCategoryDataState: DataState.success,
            products: r,
            hasMore:false,
            pageNumber: 2,
          );
        }
      },
    );
  }

  Future<void> addSupplierCategory(AddSupplierProductRequestModel request) async {
    final repository = ref.read(productSupplierRepositoryProvider);
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

  Future<void> updateSupplierCategory(int id,AddSupplierProductRequestModel request) async {
    final repository = ref.read(productSupplierRepositoryProvider);
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
    final repository = ref.read(productSupplierRepositoryProvider);
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

}


