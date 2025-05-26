import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

class CategoriesState {
  final DataState getCategoriesDataState;
  final List<CategoryModel> categories;
  final int pageNumber;
  final bool hasMore;
  final Failure? failure;

  CategoriesState({
    this.getCategoriesDataState = DataState.initial,
    this.categories = const [],
    this.pageNumber = 1,
    this.hasMore = false,
    this.failure,
  });

  CategoriesState copyWith({
    DataState? getCategoriesDataState,
    List<CategoryModel>? categories,
    int? pageNumber,
    bool? hasMore,
    Failure? failure,
  }) {
    return CategoriesState(
      getCategoriesDataState: getCategoriesDataState ?? this.getCategoriesDataState,
      categories: categories ?? this.categories,
      pageNumber: pageNumber ?? this.pageNumber,
      hasMore: hasMore ?? this.hasMore,
      failure: failure ?? this.failure,
    );
  }
}
