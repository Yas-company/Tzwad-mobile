import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';
class BottomPartOfItem extends StatelessWidget {
  const BottomPartOfItem({Key? key, required this.product}) : super(key: key);
  final ProductSupplierModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
      const BoxDecoration(color: ColorManager.colorWhite3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "الكمية : ${product.quantity}",
            style: StyleManager.getRegularStyle(
                color: ColorManager.colorWhite2),
          ),
          Text(
            "الوزن : لا يوجد",
            style: StyleManager.getRegularStyle(
                color: ColorManager.colorWhite2),
          ),
          Text(
            "النكهة : لا يوجد",
            style: StyleManager.getRegularStyle(
                color: ColorManager.colorWhite2),
          ),
        ],
      ),
    );
  }
}