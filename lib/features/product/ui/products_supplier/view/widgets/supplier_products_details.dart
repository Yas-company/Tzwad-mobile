import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/products_number_details.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/search_back_row.dart';
import '../../../../../../core/resource/values_manager.dart';
import 'all_products_number_card.dart';

class SupplierProductsDetails extends StatelessWidget {
  const SupplierProductsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorManager.colorPrimary,
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p24, vertical: AppPadding.p24),
        child: const Column(
          children: [
            Expanded(flex: 3, child: SearchBackRow()),
            Expanded(flex: 3, child: ProductsNumberDetails()),
            Expanded(flex: 4, child: AllProductsNumberCard())
          ],
        ));
  }
}
