import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';
import '../../../add_product/providers/add_product_supplier_controller_provider.dart';
import '../../../add_product/view/add_product_view.dart';
import '../../providers/products_supplier_controller_provider.dart';

class AllProductsNumberCard extends ConsumerWidget {
  const AllProductsNumberCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.colorPureWhite,
          borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: ColorManager.colorPrimary,
                    borderRadius: BorderRadius.circular(8)),
                child: const Image(
                    image: AssetImage("assets/icons/ic_store2.png")),
              ),
              const SizedBox(
                width: AppPadding.p8,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "كل المنتجات",
                      style: StyleManager.getRegularStyle(
                          color: ColorManager.colorWhite2,
                          fontSize: FontSize.s14),
                    ),
                    Text(
                      "1303",
                      style: StyleManager.getBoldStyle(
                          color: ColorManager.colorBlack1,
                          fontSize: FontSize.s28),
                    ),
                  ],
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              ref.read(pickedFileProvider.notifier).reset();
              ref.watch(addProductControllerProvider).imageFile = null;
              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProductView(),
                ),
              );

              if (result == true) {
                // استدعِ التابع بعد الرجوع
                ref.invalidate(addProductControllerProvider);
                ref.read(productsSupplierControllerProvider.notifier)
                    .getProductsSupplier();
              } else {
                ref.invalidate(addProductControllerProvider);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.colorSecondary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/ic_add.png',
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    "اضافة",
                    style: StyleManager.getMediumStyle(
                        color: ColorManager.colorPureWhite,
                        fontSize: FontSize.s14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
