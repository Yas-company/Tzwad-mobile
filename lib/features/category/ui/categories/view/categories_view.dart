import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/categories_view_body.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _onPressedBackButton(context),
        ),
        title: const Text('Categories'),
      ),
      body: const CategoriesViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
