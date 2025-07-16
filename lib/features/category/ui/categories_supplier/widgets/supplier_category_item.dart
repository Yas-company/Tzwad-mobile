import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class SupplierCategoryItem extends StatelessWidget {
  final SupplierCategories category;
  final WidgetRef ref;

  const SupplierCategoryItem({
    super.key,
    required this.category,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 18, bottom: 2),
      decoration: BoxDecoration(
        color: ColorManager.colorWhite3,
        border: Border.all(color: ColorManager.cardGreyHint.withOpacity(0.1)),
      ),
      child: ListTile(
        title: Row(
          children: [
            Text(
              category.name ?? '',
              style: StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              margin: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
              padding: const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 1),
              decoration: BoxDecoration(
                color: ColorManager.colorSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  category.productsCount.toString(),
                  style: StyleManager.getRegularStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
        subtitle: Text(
          category.field?.name ?? '',
          style: const TextStyle(fontSize: 12),
        ),
        minVerticalPadding: 0,
        contentPadding: const EdgeInsets.only(left: 10, right: 10),
        trailing:Padding(
          padding: const EdgeInsets.only(top:20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
            AppRippleWidget(
              onTap: () async {
                ref.read(isInitializedProvider.notifier).state = false;
                ref.read(pickedFileProvider.notifier).reset();
                final request = AddSupplierCategoryRequestModel(
                  id: category.id ?? 0,
                  nameAr: category.name ?? '',
                  nameEn: category.name ?? '',
                  fieldId: category.field?.id ?? 0,
                  imageUrl: category.image ?? '',
                  isEdit: true,
                );
                final result = await context.push(
                  AppRoutes.addProductSupplierView,
                  extra: request,
                );
                if (result == true) {
                  ref.read(categorySupplierControllerProvider.notifier)
                      .getSupplierCategory();
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
                final notifier = ref.read(categorySupplierControllerProvider.notifier);
                final future = notifier.deleteSupplierCategory(category.id ?? 0);
                future.then((_) {
                  ref.read(categorySupplierControllerProvider.notifier)
                      .getSupplierCategory();
                });
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
          ],
          ),
        ),
        // trailing: Padding(
        //   padding: const EdgeInsets.only(top:20),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       InkWell(
        //         onTap: () async {
        //           ref.read(isInitializedProvider.notifier).state = false;
        //           ref.read(pickedFileProvider.notifier).reset();
        //           final request = AddSupplierCategoryRequestModel(
        //             id: category.id ?? 0,
        //             nameAr: category.name ?? '',
        //             nameEn: category.name ?? '',
        //             fieldId: category.field?.id ?? 0,
        //             imageUrl: category.image ?? '',
        //             isEdit: true,
        //           );
        //
        //           final result = await context.push(
        //             AppRoutes.addProductSupplierView,
        //             extra: request,
        //           );
        //
        //           if (result == true) {
        //             ref.read(categorySupplierControllerProvider.notifier)
        //                 .getSupplierCategory();
        //           }
        //         },
        //         child: Container(
        //           height:36,width: 36,
        //           padding: const EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //             color: ColorManager.colorSecondary,
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           child: const Icon(Icons.edit, color: Colors.white,size:20,),
        //         ),
        //       ),
        //       const SizedBox(width: 10),
        //       InkWell(
        //         onTap: () {
        //           final notifier = ref.read(categorySupplierControllerProvider.notifier);
        //           final future = notifier.deleteSupplierCategory(category.id ?? 0);
        //           future.then((_) {
        //             ref.read(categorySupplierControllerProvider.notifier)
        //                 .getSupplierCategory();
        //           });
        //         },
        //         child: Container(
        //           height:36,width: 36,
        //           padding: const EdgeInsets.all(8),
        //           decoration: BoxDecoration(
        //             color: ColorManager.colorPrimary,
        //             borderRadius: BorderRadius.circular(10),
        //           ),
        //           child: const Icon(Icons.delete, color: Colors.white,
        //           size:20,),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
