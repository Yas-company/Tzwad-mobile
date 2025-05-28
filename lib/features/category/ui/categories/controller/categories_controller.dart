import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/category/providers/category_repository_provider.dart';

import 'categories_state.dart';

class CategoriesController extends AutoDisposeNotifier<CategoriesState> {
  @override
  CategoriesState build() {
    state = _onInit();
    getCategories();
    return state;
  }

  CategoriesState _onInit() => CategoriesState();

  void getCategories() async {
    final repository = ref.read(categoryRepositoryProvider);
    state = state.copyWith(
      getCategoriesDataState: DataState.loading,
    );
    final result = await repository.getCategories();
    result.fold(
      (l) => state = state.copyWith(
        getCategoriesDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        if (r.data.isEmpty) {
          state = state.copyWith(
            getCategoriesDataState: DataState.empty,
            categories: [],
            hasMore: false,
          );
        } else {
          state = state.copyWith(
            getCategoriesDataState: DataState.success,
            categories: r.data,
            hasMore: r.hasMore,
            pageNumber: 2,
          );
        }
      },
    );
  }

  void getMoreData() async {
    if (state.hasMore) {
      final repository = ref.read(categoryRepositoryProvider);
      state = state.copyWith(
        isLoadingMore: true,
      );
      final result = await repository.getCategories(
        page: state.pageNumber,
      );
      result.fold(
        (l) => state = state.copyWith(
          isLoadingMore: false,
          failure: l,
        ),
        (r) {
          final items = List<CategoryModel>.from(state.categories)..addAll(r.data);
          state = state.copyWith(
            isLoadingMore: false,
            categories: items,
            hasMore: r.hasMore,
            pageNumber: state.pageNumber + 1,
          );
        },
      );
    }
  }
}
