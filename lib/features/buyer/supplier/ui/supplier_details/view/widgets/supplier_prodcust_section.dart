import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/providers/supplier_details_controller_provider.dart';

import 'supplier_products_list_content.dart';

class SupplierProductsSection extends ConsumerWidget {
  const SupplierProductsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      supplierDetailsControllerProvider.select(
        (state) => state.getSupplierProductsDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      supplierDetailsControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );

    final products = ref.watch(
      supplierDetailsControllerProvider.select(
        (state) => state.products,
      ),
    );
    final failure = ref.read(
      supplierDetailsControllerProvider.select(
        (state) => state.supplierProductsFailure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return SupplierProductsListContent(
          items: SupplierProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return SupplierProductsListContent(
          items: products,
          isLoadingMore: isLoadingMore,
          failure: failure,
          onLoadMore: () => _onLoadMore(ref),
        );

      case DataState.empty:
        return SupplierProductsListContent(
          items: SupplierProductModel.generateFakeList(),
          isLoading: false,
        );
        // return const Center(
        //   child: AppEmptyWidget(
        //     message: 'لا يوجد منتجات',
        //   ),
        // );
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

  _onLoadMore(WidgetRef ref) {
    final supplierId = appArgs['supplier_id'] as int;
    ref.read(supplierDetailsControllerProvider.notifier).getMoreData(supplierId);
  }
}
