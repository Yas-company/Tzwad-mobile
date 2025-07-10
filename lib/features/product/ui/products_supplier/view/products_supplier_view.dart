import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart' show AssetsManager;
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart' show StyleManager;
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/header_section.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/loading_supplier_category.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/supplier_category_item.dart';

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

    final searchQuery = ref.watch(supplierSearchQueryProvider);
    final categories = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.products,
      ),
    );

    final failure = ref.read(
      productSupplierControllerProvider.select(
            (state) => state.failure,
      ),
    );

    // 🔍 Filter based on search query
    final filteredCategories = categories.where((cat) {
      final name = cat.name?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    switch (state) {
      case DataState.loading:
        return Column(
          children: [
            const SupplierHeaderSection(),
            Expanded(
              child: Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) => const LoadingSupplierCategory(),
                ),
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
                      : ListView.builder(
                    itemCount: filteredCategories.length,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemBuilder: (ctx, i) =>
                        SupplierCategoryItem(category:filteredCategories[i],ref:ref),
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
}

