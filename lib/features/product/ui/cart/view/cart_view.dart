import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: const CartViewBody(),
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final state = ref.watch(
            cartControllerProvider.select(
              (value) => value.getProductsDataState,
            ),
          );
          if (state == DataState.success) {
            return Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: AppButtonWidget(
                label: 'Checkout',
                onPressed: () => _onPressedCheckoutButton(ref, context),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  _onPressedCheckoutButton(WidgetRef ref, BuildContext context) {
    context.pushNamed(AppRoutes.underDevelopmentRoute);
  }
}
