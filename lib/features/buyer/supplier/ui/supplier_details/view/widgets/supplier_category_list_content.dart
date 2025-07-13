import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';

import 'item_supplier_category.dart';

class SupplierCategoryListContent extends StatelessWidget {
  const SupplierCategoryListContent({
    super.key,
    this.isLoading = false,
    required this.items,
  });

  final bool isLoading;
  final List<SupplierCategoryModel> items;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: SizedBox(
        height: AppSize.s40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              ItemSupplierCategory(
                category: items[index],
              ),
          separatorBuilder: (BuildContext context, int index) =>
          const Gap(
            AppPadding.p12,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
          ),
          itemCount: items.length,
        ),
      ),
    );
  }
}
