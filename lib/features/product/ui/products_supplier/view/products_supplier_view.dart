import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/supplier_products_Listview.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/supplier_products_details.dart';

class ProductsSupplierView extends ConsumerStatefulWidget {
  const ProductsSupplierView({super.key});

  @override
  ConsumerState<ProductsSupplierView> createState() => ProductsSupplierViewState();
}

class ProductsSupplierViewState extends ConsumerState<ProductsSupplierView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(categorySupplierControllerProvider.notifier).getSupplierFields();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: Column(
        children: [
          SupplierProductsDetails(),
          Expanded(child: SupplierProductsListView()),
        ],
      ),
    );
  }

}