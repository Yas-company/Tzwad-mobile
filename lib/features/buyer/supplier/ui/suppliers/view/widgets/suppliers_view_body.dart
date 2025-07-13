import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/suppliers/providers/suppliers_controller_provider.dart';

import 'suppliers_grid_list_content.dart';
import 'suppliers_list_content.dart';

class SuppliersViewBody extends ConsumerWidget {
  const SuppliersViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      suppliersControllerProvider.select(
        (state) => state.getSuppliersDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      suppliersControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );

    final suppliers = ref.watch(
      suppliersControllerProvider.select(
        (state) => state.suppliers,
      ),
    );
    final failure = ref.read(
      suppliersControllerProvider.select(
        (state) => state.failure,
      ),
    );

    final isGridView = ref.watch(
      suppliersControllerProvider.select(
        (state) => state.isGridView,
      ),
    );
    switch (state) {
      case DataState.loading:
        return SuppliersGridListContent(
          items: SupplierModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        if (isGridView) {
          'Mohamad joumani isGridView$isGridView'.log();
          return SuppliersGridListContent(
            items: suppliers,
            isLoadingMore: isLoadingMore,
            failure: failure,
            onLoadMore: () => _onLoadMore(ref),
          );
        } else {
          'Mohamad joumani isGridView $isGridView'.log();
          return SuppliersListContent(
            items: suppliers,
            isLoadingMore: isLoadingMore,
            failure: failure,
            onLoadMore: () => _onLoadMore(ref),
          );
        }

      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'لا يوجد موردين',
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

  _onLoadMore(WidgetRef ref) {
    ref.read(suppliersControllerProvider.notifier).getMoreData();
  }
}
