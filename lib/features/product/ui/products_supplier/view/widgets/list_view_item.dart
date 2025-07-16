import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/top_part_of_item.dart';
import '../../../../../../core/resource/values_manager.dart';
import 'bottom_part_of_item.dart';
class ListViewItem extends ConsumerWidget {
  const ListViewItem({super.key, required this.product});
  final ProductSupplierModel product;
  @override
  Widget build(BuildContext context,ref) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.p14, vertical: AppPadding.p8),
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          border: Border.all(color: ColorManager.colorWhite3, width: 0.2)),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: TopPartOfItem(product: product),
          ),
          Expanded(
            flex: 1,
            child: BottomPartOfItem(product: product),
          ),
        ],
      ),
    );
  }

}




