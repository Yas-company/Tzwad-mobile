import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';
import 'package:tzwad_mobile/features/category/ui/categories/hooks/categories_scroll_controller_hook.dart';

import 'item_category.dart';

class CategoryGridListContent extends HookConsumerWidget {
  const CategoryGridListContent({
    super.key,
    this.isLoading = false,
    this.isLoadingMore = false,
    required this.categories,
    this.onLoadMore,
    this.failure,
  });

  final bool isLoading;
  final bool isLoadingMore;
  final List<CategoryModel> categories;

  final Failure? failure;
  final Function()? onLoadMore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useCategoriesScrollController(
      onLoadMore: onLoadMore,
    );
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        controller: controller,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppPadding.p12,
          mainAxisSpacing: AppPadding.p12,
          childAspectRatio: 1.2,
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) {
          if (isLoadingMore && index >= categories.length) {
            return Skeletonizer(
              enabled: true,
              child: ItemCategory(
                category: CategoryModel.fake(),
              ),
            );
          }
          if (failure != null && index == categories.length) {
            return Text(
              failure!.message,
            );
          }
          return ItemCategory(
            category: categories[index],
          );
        },
        itemCount: itemCount,
      ),
    );
  }

  int get itemCount => isLoadingMore
      ? categories.length + 4
      : failure != null
          ? categories.length + 1
          : categories.length;
}
