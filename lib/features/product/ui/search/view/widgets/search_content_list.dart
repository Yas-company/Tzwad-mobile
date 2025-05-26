import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/search/providers/search_controller_provider.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/product_list_content.dart';

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
        return ProductListContent(
          products: ProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return ProductListContent(
          products: products,
          isLoading: false,
          onPressedFavoriteButton: (productId, value) => _onPressedFavoriteButton(ref, productId, value),
        );
      case DataState.empty:
        return const AppEmptyWidget(
          message: 'No products found.',
        );
      case DataState.failure:
        return AppFailureWidget(
          failure: failure,
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
}
