import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/view/widgets/appBar_add_product.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/view/widgets/list_view_feilds.dart';
import '../providers/add_product_supplier_controller_provider.dart';

class AddProductView extends HookConsumerWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(addProductControllerProvider);

    return Stack(
      children: [
        const AppScaffoldWidget(
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: AppBarAddProduct(),
              ),
              Expanded(
                flex: 9,
                child: ListViewFeilds()
              ),
            ],
          ),
        ),

        if (state.isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const AppLoadingWidget(),
          ),
      ],
    );
  }


}
