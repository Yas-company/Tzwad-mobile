import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/features/category/ui/category_details/providers/category_details_controller_provider.dart';

import 'widgets/categories_details_view_body.dart';

class CategoryDetailsView extends ConsumerStatefulWidget {
  const CategoryDetailsView({super.key});

  @override
  ConsumerState<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends ConsumerState<CategoryDetailsView> {
  @override
  void initState() {
    super.initState();
    final categoryId = appArgs['category_id'];
    Future.microtask(() {
      ref.read(categoryDetailsControllerProvider.notifier).getProductsByCategory(categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _onPressedBackButton(context),
        ),
        title: Text(
          'Products for ${appArgs['category_name']}',
        ),
      ),
      body: const CategoriesDetailsViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
