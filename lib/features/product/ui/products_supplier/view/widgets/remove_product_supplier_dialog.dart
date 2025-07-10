import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import '../../controller/products_supplier_state.dart';
import '../../providers/products_supplier_controller_provider.dart';

class RemoveProductSupplierDialog extends ConsumerWidget {
  const RemoveProductSupplierDialog({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // استماع للتغييرات في حالة الحذف
    ref.listen<ProductsSupplierState>(
      productsSupplierControllerProvider,
      (previous, next) {
        if (previous?.deleteProductDataState != next.deleteProductDataState) {
          if (next.deleteProductDataState == DataState.success) {
            // عند نجاح الحذف، اغلاق الدايلوج واعادة جلب المنتجات
            context.showMessage(message: "تم حذف العنصر بنجاح");
            Navigator.of(context).pop();
            ref
                .read(productsSupplierControllerProvider.notifier)
                .getProductsSupplier();
          } else if (next.deleteProductDataState == DataState.failure) {
            // عند الخطأ، اظهار رسالة خطأ
            context.showMessage(message: "حدث خطأ .. لم يتم حذف العنصر");
            Navigator.of(context).pop(); // اغلاق الدايلوج حتى لو فشل
          }
        }
      },
    );

    final state = ref.watch(productsSupplierControllerProvider);

    return AlertDialog(
      title: Text(
        'حذف المنتج',
        style: StyleManager.getBoldStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s18,
        ),
      ),
      content: Text(
        'هل أنت متأكد من حذف المنتج؟',
        style: StyleManager.getRegularStyle(
          color: ColorManager.blackColor,
          fontSize: FontSize.s14,
        ),
      ),
      actions: [
        if (state.deleteProductDataState == DataState.loading)
          const Padding(
            padding: EdgeInsets.all(12),
            child: AppLoadingWidget(color: ColorManager.colorPrimary),
          )
        else ...[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: StyleManager.getMediumStyle(color: ColorManager.colorRed),
            ),
          ),
          TextButton(
            onPressed: () => ref
                .read(productsSupplierControllerProvider.notifier)
                .deleteProductSupplier(id),
            child: Text(
              'حذف',
              style:
                  StyleManager.getMediumStyle(color: ColorManager.colorPrimary),
            ),
          ),
        ],
      ],
    );
  }
}
