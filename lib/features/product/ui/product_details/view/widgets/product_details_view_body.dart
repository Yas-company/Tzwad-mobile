import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/providers/product_details_controller_provider.dart';

import 'product_details_content.dart';

class ProductDetailsViewBody extends ConsumerWidget {
  const ProductDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      productDetailsControllerProvider.select(
        (value) => value.getProductDetailsDataState,
      ),
    );
    final product = ref.read(
      productDetailsControllerProvider.select(
        (value) => value.product,
      ),
    );

    final failure = ref.read(
      productDetailsControllerProvider.select(
        (value) => value.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return ProductDetailsContent(
          product: ProductModel.fake(),
          isLoading: true,
        );
      case DataState.success:
        return ProductDetailsContent(
          product: product,
          isLoading: false,
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
