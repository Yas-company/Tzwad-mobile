import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import '../../../../../../core/util/data_state.dart';
import '../../hooks/use_auto_load_scroll_controller_hook.dart';
import '../../providers/products_supplier_controller_provider.dart';
import 'list_view_item.dart';

class SupplierProductsListView extends HookConsumerWidget {
  const SupplierProductsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productsSupplierControllerProvider);
    final notifier = ref.read(productsSupplierControllerProvider.notifier);
    final searchQuery = ref.watch(supplierSearchQueryProvider);

    final scrollController = useAutoLoadScrollController(
      hasMore: state.hasMore,
      isLoading: state.isLoadingMore,
      onLoadMore: notifier.getMoreData,
    );

    if (state.getProductsSupplierDataState == DataState.loading) {
      return const Center(
        child: AppLoadingWidget(color: ColorManager.colorPrimary),
      );
    }

    if (state.getProductsSupplierDataState == DataState.failure) {
      return const AppEmptyWidget(message: "حدث خطأ أثناء تحميل المنتجات");
    }

    final filteredProducts = state.productsSupplier.where((product) {
      final name = product.name?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    if (filteredProducts.isEmpty) {
      return const AppEmptyWidget(message: "لا توجد نتائج مطابقة");
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: filteredProducts.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < filteredProducts.length) {
          final product = filteredProducts[index];
          return ListViewItem(product: product);
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorManager.colorPrimary,
              ),
            ),
          );
        }
      },
    );
  }
}
