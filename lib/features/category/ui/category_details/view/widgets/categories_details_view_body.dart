import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/category/ui/category_details/providers/category_details_controller_provider.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/product_grid_list_content.dart';

class CategoriesDetailsViewBody extends ConsumerWidget {
  const CategoriesDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      categoryDetailsControllerProvider.select(
        (state) => state.getProductsByCategoryDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      categoryDetailsControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );
    final products = ref.watch(
      categoryDetailsControllerProvider.select(
        (state) => state.products,
      ),
    );
    final failure = ref.read(
      categoryDetailsControllerProvider.select(
        (state) => state.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return ProductGridListContent(
          products: ProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return ProductGridListContent(
          isLoadingMore: isLoadingMore,
          products: products,
          failure: failure,
          onLoadMore: () => _onLoadMore(ref),
          onPressedFavoriteButton: (productId, value) => _onPressedFavoriteButton(ref, productId, value),
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'No products found.',
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

  _onPressedFavoriteButton(WidgetRef ref, int productId, bool value) {
    ref.read(categoryDetailsControllerProvider.notifier).toggleFavorite(productId, value);
  }

  _onLoadMore(WidgetRef ref) {
    final categoryId = appArgs['category_id'];
    ref.read(categoryDetailsControllerProvider.notifier).getMoreData(categoryId);
  }
}
