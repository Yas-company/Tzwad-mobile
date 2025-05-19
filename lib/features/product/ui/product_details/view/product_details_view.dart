import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/providers/product_details_controller_provider.dart';

import 'widgets/product_add_to_cart_widget.dart';
import 'widgets/product_plus_minus_widget.dart';
import 'widgets/product_details_view_body.dart';

class ProductDetailsView extends ConsumerStatefulWidget {
  const ProductDetailsView({super.key});

  @override
  ConsumerState<ProductDetailsView> createState() => _UpsertUserViewState();
}

class _UpsertUserViewState extends ConsumerState<ProductDetailsView> {
  @override
  void initState() {
    super.initState();
    final id = appArgs['id'];
    Future.microtask(() {
      ref.read(productDetailsControllerProvider.notifier).getProduct(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      userSafeArea: false,
      body: const ProductDetailsViewBody(),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(
            productDetailsControllerProvider.select(
              (value) => value.getProductDetailsDataState,
            ),
          );

          final product = ref.watch(
            productDetailsControllerProvider.select(
              (value) => value.product,
            ),
          );
          return state == DataState.success
              ? Container(
                  decoration: const BoxDecoration(
                    color: ColorManager.blackColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(AppPadding.p16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProductPlusMinusWidget(),
                          ProductAddToCartWidget(),
                        ],
                      ),
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}
