import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/favorite_products/providers/favorite_products_controller_provider.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/product_grid_list_content.dart';

class FavoriteProductsViewBody extends ConsumerWidget {
  const FavoriteProductsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      favoriteProductsControllerProvider.select(
        (state) => state.getFavoriteProductsDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      favoriteProductsControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );
    final products = ref.watch(
      favoriteProductsControllerProvider.select(
        (state) => state.products,
      ),
    );
    final failure = ref.read(
      favoriteProductsControllerProvider.select(
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
    ref.read(favoriteProductsControllerProvider.notifier).toggleFavorite(productId, value);
  }

  _onLoadMore(WidgetRef ref) {
    ref.read(favoriteProductsControllerProvider.notifier).getMoreData();
  }
}
