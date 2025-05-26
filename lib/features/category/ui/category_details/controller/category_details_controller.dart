import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/providers/product_repository_provider.dart';
import 'category_details_state.dart';

class CategoryDetailsController extends AutoDisposeNotifier<CategoryDetailsState> {
  @override
  CategoryDetailsState build() {
    state = _onInit();
    return state;
  }

  CategoryDetailsState _onInit() => CategoryDetailsState();

  void getProductsByCategory(int categoryId) async {
    final repository = ref.read(categoryRepositoryProvider);
    state = state.copyWith(
      getProductsByCategoryDataState: DataState.loading,
    );
    final result = await repository.getProductsByCategory(categoryId: categoryId);
    result.fold(
      (l) => state = state.copyWith(
        getProductsByCategoryDataState: DataState.failure,
        failure: l,
      ),
      (r) {
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

  void getPage(int categoryId) async {
    if (state.hasMore) {
      final repository = ref.read(categoryRepositoryProvider);
      state = state.copyWith();
      final result = await repository.getProductsByCategory(
        categoryId: categoryId,
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          failure: l,
        ),
        (r) {
          List<ProductModel> newDataList = state.products;
          newDataList.addAll(r.data);
          state = state.copyWith(
            products: newDataList,
            hasMore: r.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }

  void toggleFavorite(int productId, bool value) async {
    final repository = ref.read(productRepositoryProvider);
    if (value) {
      await repository.addProductToFavorites(id: productId);
    } else {
      await repository.removeProductFromFavorites(id: productId);
    }
  }
}
