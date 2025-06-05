import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/search/providers/search_controller_provider.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/product_grid_list_content.dart';

import 'search_init_widget.dart';

class SearchContentList extends ConsumerWidget {
  const SearchContentList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      searchControllerProvider.select(
        (state) => state.getFilterProductsDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      searchControllerProvider.select(
        (state) => state.isLoadingMore,
      ),
    );
    final products = ref.watch(
      searchControllerProvider.select(
        (state) => state.products,
      ),
    );
    final failure = ref.read(
      searchControllerProvider.select(
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
          onPressedAddToCartButton: (product) => _onPressedAddToCartButton(ref, product),
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
      case DataState.initial:
        return const Center(
          child: SearchInitWidget(),
        );
    }
  }

  _onPressedFavoriteButton(WidgetRef ref, int productId, bool value) {
    ref.read(searchControllerProvider.notifier).toggleFavorite(productId, value);
  }

  _onPressedAddToCartButton(WidgetRef ref, ProductModel product) {
    ref.read(searchControllerProvider.notifier).addProductToCart(product);
  }

  _onLoadMore(WidgetRef ref) {
    ref.read(searchControllerProvider.notifier).getMoreData();
  }
}
