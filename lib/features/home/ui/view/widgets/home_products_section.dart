import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/home/ui/providers/home_controller_provider.dart';
import 'package:tzwad_mobile/features/home/ui/view/widgets/home_product_list_content.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class HomeProductsSection extends ConsumerWidget {
  const HomeProductsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      homeControllerProvider.select(
        (value) => value.getProductsDataState,
      ),
    );
    final products = ref.watch(
      homeControllerProvider.select(
        (value) => value.products,
      ),
    );

    final failure = ref.watch(
      homeControllerProvider.select(
        (value) => value.failure,
      ),
    );

    switch (state) {
      case DataState.loading:
        return HomeProductListContent(
          products: ProductModel.generateFakeList(),
          isLoading: true,
        );
      case DataState.success:
        return HomeProductListContent(
          products: products,
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
