import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/product/ui/search/view/filter_products_bottom_sheet.dart';

import 'widgets/search_view_body.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.filter_list_outlined),
          onPressed: () => _onPressedFilterButton(context, ref),
        ),
        title: const Text('Search'),
      ),
      body: const SearchViewBody(),
    );
  }

  _onPressedFilterButton(BuildContext context, WidgetRef ref) {
    FilterProductsBottomSheet.show(context, ref);
  }
}
