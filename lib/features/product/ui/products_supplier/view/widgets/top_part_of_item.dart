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

class TopPartOfItem extends ConsumerWidget {
  const TopPartOfItem({super.key, required this.product});
  final ProductSupplierModel product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(width: AppPadding.p8),
                // Image
                Container(
                  width: 60,
                  height: 60,
                  color: ColorManager.colorWhite3,
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
                  ),
                ),

                const SizedBox(width: AppPadding.p6),

                // Name + Price
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: StyleManager.getRegularStyle(
                          color: ColorManager.blackColor,
                          fontSize: FontSize.s18,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Text(
                            product.price,
                            style: StyleManager.getBoldStyle(
                              color: ColorManager.blackColor,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          const SizedBox(width: AppPadding.p4),
                          const Image(
                            image: AssetImage("assets/icons/ic_after_price.png"),
                            width: 9,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Row(children: [
              AppRippleWidget(
                onTap: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditProductView("${product.id}"),
                    ),
                  );

                  if (result == true) {
                    ref.invalidate(EditProductControllerProvider);
                    ref.read(productsSupplierControllerProvider.notifier).getProductsSupplier();
                  } else {
                    ref.invalidate(EditProductControllerProvider);
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.colorSecondary,
                  ),
                  child: Image.asset('assets/icons/ic_edit.png'),
                ),
              ),
              const SizedBox(width:6),
              AppRippleWidget(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => RemoveProductSupplierDialog(
                      id: "${product.id}",
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.colorPrimary,
                  ),
                  child: Image.asset('assets/icons/ic_delete.png'),
                ),
              ),
              const SizedBox(width:10),
            ],
          )
        ],
      ),
    );
  }
}
