import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/view/widgets/appBar_edit_product.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/view/widgets/listView_edit_feilds.dart';
import '../providers/edit_product_supplier_controller_provider.dart';

class EditProductView extends HookConsumerWidget {
  const EditProductView(this.productId, {super.key});
   final String productId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(EditProductControllerProvider);
    return Stack(
      children: [
        AppScaffoldWidget(
          body: Column(
            children: [
              const Expanded(
                flex: 1,
                child:AppBarEditProduct()
              ),
              Expanded(
                flex: 9,
                child:ListViewEditFeilds(productId),
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



