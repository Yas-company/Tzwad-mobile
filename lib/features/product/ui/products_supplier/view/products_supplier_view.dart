import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/supplier_products_Listview.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/supplier_products_details.dart';

class ProductsSupplierView extends ConsumerWidget {
  const ProductsSupplierView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppScaffoldWidget(
      body: Column(
        children: [
          Expanded(flex: 12, child: SupplierProductsDetails()),
          Expanded(flex: 20, child: SupplierProductsListView()),
        ],
      ),
    );
  }
}
