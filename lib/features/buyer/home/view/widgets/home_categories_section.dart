import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/home/providers/home_buyer_controller_provider.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

import 'home_category_list_content.dart';

class HomeCategoriesSection extends ConsumerWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.getCategoriesDataState,
      ),
    );
    final categories = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.categories,
      ),
    );

    final failure = ref.watch(
      homeBuyerControllerProvider.select(
        (value) => value.failure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return HomeCategoryListContent(
          categories: CategoryModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return HomeCategoryListContent(
          categories: categories,
          isLoading: false,
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
