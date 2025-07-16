import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/widgets/header_section.dart';
import 'package:tzwad_mobile/features/category/ui/categories_supplier/widgets/paginated_supplier_category_list.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class CategoriesSupplierView extends ConsumerStatefulWidget {
  const CategoriesSupplierView({super.key});

  @override
  ConsumerState<CategoriesSupplierView> createState() => _CategoriesSupplierViewState();
}

class _CategoriesSupplierViewState extends ConsumerState<CategoriesSupplierView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categorySupplierControllerProvider.notifier).getSupplierCategory();
      ref.read(categorySupplierControllerProvider.notifier).getSupplierFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: CategoriesSupplierViewBody(),
    );
  }

}

class CategoriesSupplierViewBody extends ConsumerWidget {
  const CategoriesSupplierViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(supplierSearchQueryProvider);
    final products = ref.watch(
      categorySupplierControllerProvider.select((state) => state.products,),);
    // 🔍 Filter based on search query
    final filteredCategories = products.where((cat) {
      final name = cat.name?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    final isLoading = ref.watch(
      categorySupplierControllerProvider.select(
            (state) => state.deleteCategoryState == DataState.loading,
      ),
    );
    final state = ref.watch(
      categorySupplierControllerProvider.select(
            (state) => state.getProductsByCategoryDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      categorySupplierControllerProvider.select(
            (state) => state.isLoadingMore,
      ),
    );
    final failure = ref.read(
      categorySupplierControllerProvider.select(
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
    ref.read(categorySupplierControllerProvider.notifier).getMoreData();
  }
}

