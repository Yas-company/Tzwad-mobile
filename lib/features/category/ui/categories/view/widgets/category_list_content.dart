import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

import 'item_category.dart';

class CategoryListContent extends HookConsumerWidget {
  const CategoryListContent({
    super.key,
    required this.categories,
    this.isLoading = false,
  });

  final List<CategoryModel> categories;
  final bool isLoading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = useProductsScrollController(
    //   ref: ref,
    // );
    return Skeletonizer(
      enabled: isLoading,
      child: GridView.builder(
        // controller: controller,
        // physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppPadding.p12,
          mainAxisSpacing: AppPadding.p12,
          childAspectRatio: 1.2,
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) => ItemCategory(
          category: categories[index],
        ),
        itemCount: categories.length,
      ),
    );
  }
}
