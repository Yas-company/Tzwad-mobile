import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/widgets/header_section.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/widgets/paginated_supplier_category_list.dart';

class ProductsSupplierView extends ConsumerStatefulWidget {
  const ProductsSupplierView({super.key});

  @override
  ConsumerState<ProductsSupplierView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends ConsumerState<ProductsSupplierView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productSupplierControllerProvider.notifier).getSupplierCategory();
      ref.read(productSupplierControllerProvider.notifier).getSupplierFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: ProductsSupplierViewBody(),
    );
  }

}

class ProductsSupplierViewBody extends ConsumerWidget {
  const ProductsSupplierViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(supplierSearchQueryProvider);
    final products = ref.watch(
      productSupplierControllerProvider.select((state) => state.products,
      ),
    );
    // 🔍 Filter based on search query
    final filteredCategories = products.where((cat) {
      final name = cat.name?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    final isLoading = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.deleteCategoryState == DataState.loading,
      ),
    );
    final state = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.getProductsByCategoryDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.isLoadingMore,
      ),
    );
    final failure = ref.read(
      productSupplierControllerProvider.select(
            (state) => state.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return Column(
          children: [
            const SupplierHeaderSection(),
            Expanded(
              child: PaginatedSupplierCategoryList(
                products: SupplierCategories.generateFakeList(),
                isLoading: true,
              ),
            ),
          ],
        );

      case DataState.success:
        return Column(
          children: [
            const SupplierHeaderSection(),
            Expanded(
              child: Stack(
                children: [
                  filteredCategories.isEmpty
                      ? const AppEmptyWidget(message: 'لا توجد نتائج مطابقة.')
                      :PaginatedSupplierCategoryList(
                    isLoadingMore: isLoadingMore,
                    products: filteredCategories,
                    failure: failure,
                    onLoadMore: () => _onLoadMore(ref),
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'لا توجد تصنيفات.',
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
    ref.read(productSupplierControllerProvider.notifier).getMoreData();
  }
}

