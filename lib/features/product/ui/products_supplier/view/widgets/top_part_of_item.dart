import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_supplier_model.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/view/edit_product_view.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/view/widgets/remove_product_supplier_dialog.dart';
import '../../../../../../core/app_widgets/app_ripple_widget.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';
import '../../../edit_product/providers/edit_product_supplier_controller_provider.dart';
import '../../providers/products_supplier_controller_provider.dart';
class TopPartOfItem extends  ConsumerWidget  {
  const TopPartOfItem({super.key, required this.product});
  final ProductSupplierModel product;
  @override
  Widget build(BuildContext context,ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Stack(
        children: [
          Row(
            children: [
              const SizedBox(width: AppPadding.p8),
              Container(
                width: MediaQuery.of(context).size.width * 0.16,
                color: ColorManager.colorWhite3,
                child: Image.network(
                  product.image,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.image_not_supported),
                ),
              ),
              const SizedBox(width: AppPadding.p6),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: StyleManager.getRegularStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s18),
                  ),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: StyleManager.getBoldStyle(
                            color: ColorManager.blackColor,
                            fontSize: FontSize.s14),
                      ),
                      const SizedBox(
                        width: AppPadding.p4,
                      ),
                      const Image(
                        image: AssetImage(
                            "assets/icons/ic_after_price.png"),
                        width: 9,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: AppPadding.p6,
            left: MediaQuery.of(context).size.width * 0.03,
            child: AppRippleWidget(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => RemoveProductSupplierDialog(
                    id: "${product.id}",
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.colorPrimary,
                ),
                child: Image.asset('assets/icons/ic_delete.png'),
              ),
            ),
          ),
          Positioned(
            top: AppPadding.p6,
            left: MediaQuery.of(context).size.width * 0.18,
            child: AppRippleWidget(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProductView("${product.id}"),
                  ),
                );

                if (result == true) {
                  // استدعِ التابع بعد الرجوع
                  ref.invalidate(EditProductControllerProvider);

                  ref
                      .read(productsSupplierControllerProvider
                      .notifier)
                      .getProductsSupplier();
                } else {
                  ref.invalidate(EditProductControllerProvider);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.13,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorManager.colorSecondary,
                ),
                child: Image.asset('assets/icons/ic_edit.png'),
              ),
            ),
          )
        ],
      ),
    );
  }
}