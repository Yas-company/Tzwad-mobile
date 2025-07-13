import 'package:flutter/material.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_product_model.dart';

import 'supplier_categories_section.dart';
import 'supplier_prodcust_section.dart';
import 'supplier_products_list_content.dart';

class SupplierDetailsViewBody extends StatelessWidget {
  const SupplierDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SupplierCategoriesSection(),
        Expanded(
          child: SupplierProductsSection(),
        ),
      ],
    );
  }
}
