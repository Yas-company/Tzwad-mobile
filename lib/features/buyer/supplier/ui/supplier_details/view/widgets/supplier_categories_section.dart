import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/providers/supplier_details_controller_provider.dart';

import 'supplier_category_list_content.dart';

class SupplierCategoriesSection extends ConsumerWidget {
  const SupplierCategoriesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      supplierDetailsControllerProvider.select(
        (state) => state.getSupplierCategoriesDataState,
      ),
    );

    final categories = ref.watch(
      supplierDetailsControllerProvider.select(
        (state) => state.categories,
      ),
    );
    final failure = ref.read(
      supplierDetailsControllerProvider.select(
        (state) => state.supplierCategoriesFailure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return SupplierCategoryListContent(
          items: SupplierCategoryModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return SupplierCategoryListContent(
          items: categories,
        );

      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'لا يوجد اصناف',
          ),
        );
      case DataState.failure:
        return Center(
          child: AppFailureWidget(
            failure: failure,
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
