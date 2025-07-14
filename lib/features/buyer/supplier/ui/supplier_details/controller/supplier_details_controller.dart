import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/providers/cart_repository_provider.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/providers/supplier_repository_provider.dart';

import 'supplier_details_state.dart';

class SupplierDetailsController extends AutoDisposeNotifier<SupplierDetailsState> {
  @override
  SupplierDetailsState build() {
    state = _onInit();
    return state;
  }

  SupplierDetailsState _onInit() => SupplierDetailsState();

  void changeCategory(SupplierCategoryModel category) {
    final updatedCategories = state.categories
        .map(
          (e) => SupplierCategoryModel(
            id: e.id,
            name: e.name,
            supplierId: e.supplierId,
            image: e.image,
            field: e.field,
            fieldId: e.fieldId,
            productsCount: e.productsCount,
            isSelected: e.id == category.id,
          ),
        )
        .toList();
    state = state.copyWith(
      categories: updatedCategories,
    );
    getProducts(
      supplierId: category.supplierId!,
      categoryId: category.id ?? -1,
    );
  }

  void getCategories(int supplierId) async {
    final repository = ref.read(supplierRepositoryProvider);
    state = state.copyWith(
      getSupplierCategoriesDataState: DataState.loading,
    );
    final result = await repository.getCategories(
      supplierId: supplierId,
    );
    result.fold(
      (l) => state = state.copyWith(
        getSupplierCategoriesDataState: DataState.failure,
        supplierCategoriesFailure: l,
      ),
      (r) {
        if (r.isEmpty) {
          state = state.copyWith(
            getSupplierCategoriesDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getSupplierCategoriesDataState: DataState.success,
            categories: r,
          );
        }
      },
    );
  }

  void getProducts({
    required int supplierId,
    int categoryId = -1,
  }) async {
    final repository = ref.read(supplierRepositoryProvider);
    state = state.copyWith(
      getSupplierProductsDataState: DataState.loading,
    );
    final result = await repository.getProducts(
      supplierId: supplierId,
      categoryId: categoryId,
    );
    result.fold(
      (l) => state = state.copyWith(
        getSupplierProductsDataState: DataState.failure,
        supplierProductsFailure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getSupplierProductsDataState: DataState.empty,
            products: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getSupplierProductsDataState: DataState.success,
            products: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData(int supplierId) async {
    if (state.hasMore && !state.isLoadingMore) {
      final repository = ref.read(supplierRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getProducts(
        supplierId: supplierId,
        page: state.pageNumber,
        categoryId: state.categories.firstWhere((element) => element.isSelected).id!,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          supplierProductsFailure: l,
        ),
        (r) {
          final items = List<SupplierProductModel>.from(state.products)..addAll(r.data);
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

  void addToCart(SupplierProductModel product) async {
    final repository = ref.read(cartRepositoryProvider);
    product.isLoading = true;
    state = state.copyWith(
      products: state.products
          .map(
            (e) => e.id == product.id ? product : e,
          )
          .toList(),
    );
    final result = await repository.addToCart(
      productId: product.id!,
    );
    result.fold(
      (l) {
        product.isLoading = false;
        state = state.copyWith(
          products: state.products
              .map(
                (e) => e.id == product.id ? product : e,
              )
              .toList(),
        );
      },
      (r) {
        product.isLoading = false;
        // product.cartQuantity = (product.cartQuantity ?? 0) + 1;
        state = state.copyWith(
          products: state.products
              .map(
                (e) => e.id == product.id ? product : e,
              )
              .toList(),
        );
      },
    );
  }
}
