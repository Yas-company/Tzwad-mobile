import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/cart_view_body.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _onPressedBackButton(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('السلة'),
        ),
        body: const CartViewBody());
  }

  _onPressedBackButton(BuildContext context) {
    Navigator.pop(context);
  }
}
