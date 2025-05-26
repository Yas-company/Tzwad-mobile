import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/category/ui/categories/providers/categories_controller_provider.dart';

import 'category_list_content.dart';

class CategoriesViewBody extends ConsumerWidget {
  const CategoriesViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      categoriesControllerProvider.select(
        (state) => state.getCategoriesDataState,
      ),
    );
    final categories = ref.watch(
      categoriesControllerProvider.select(
        (state) => state.categories,
      ),
    );
    final failure = ref.read(
      categoriesControllerProvider.select(
        (state) => state.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return CategoryListContent(
          categories: CategoryModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return CategoryListContent(
          categories: categories,
          isLoading: false,
        );
      case DataState.empty:
        return const AppEmptyWidget(
          message: 'No Categories found.',
        );
      case DataState.failure:
        return AppFailureWidget(
          failure: failure,
        );
      default:
        return const SizedBox();
    }
  }
}
