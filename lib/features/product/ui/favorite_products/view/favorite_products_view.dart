import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/favorite_products_view_body.dart';

class FavoriteProductsView extends StatelessWidget {
  const FavoriteProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: FavoriteProductsViewBody(),
    );
  }
}
