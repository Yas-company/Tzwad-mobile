import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/products/providers/product_controller_provider.dart';

import 'product_list_content.dart';

class ProductsViewBody extends ConsumerWidget {
  const ProductsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      productsControllerProvider.select(
        (state) => state.getProductsDataState,
      ),
    );
    final products = ref.watch(
      productsControllerProvider.select(
        (state) => state.products,
      ),
    );
    final failure = ref.read(
      productsControllerProvider.select(
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
        );
      case DataState.empty:
        return const AppEmptyWidget(
          message: 'No products found.',
        );
      case DataState.failure:
        return AppFailureWidget(
          failure: failure,
        );
      default:
        return const SizedBox();
    }
  }
}
