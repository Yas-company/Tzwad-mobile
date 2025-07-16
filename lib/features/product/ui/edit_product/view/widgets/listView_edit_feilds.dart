import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/hooks/edit_product_supplier_ar_desc.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/hooks/edit_product_supplier_en_desc.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/hooks/edit_product_supplier_min_order_quantity_hook.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/hooks/edit_product_supplier_quantity_hook.dart';
import 'package:tzwad_mobile/features/product/ui/edit_product/hooks/edit_product_supplier_stockQty_hook%20.dart';
import '../../../../../../core/app_widgets/app_drop_down_menu_widget.dart';
import '../../../../../../core/network/failure.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';
import '../../../../../../core/util/state_render/result.dart';
import '../../../../../../core/util/unit.dart';
import '../../hooks/edit_product_supplier_ar_name.dart';
import '../../hooks/edit_product_supplier_en_name.dart';
import '../../hooks/edit_product_supplier_price_hook .dart';
import '../../providers/edit_product_supplier_controller_provider.dart';


class ListViewEditFeilds  extends HookConsumerWidget {
  const ListViewEditFeilds(this.productId, {super.key});
  final String productId;
  @override
  Widget build(BuildContext context,ref) {
    final nameArController = useEditProductNameArController(ref: ref);
    final nameEnController = useEditProductNameEnController(ref: ref);
    final descArController = useEditProductDescArController(ref: ref);
    final descEnController = useEditProductDescEnController(ref: ref);
    final minOrderController = useEditProductMinOrderController(ref: ref);
    final stockQtyController = useEditProductStockQtyController(ref: ref);
    final priceController = useEditProductPriceController(ref: ref);
    final quantityController = useEditProductQuantityController(ref: ref);

    final state = ref.watch(EditProductControllerProvider);
    final controller = ref.read(EditProductControllerProvider.notifier);
    return  ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      children: [
        const SizedBox(height: 16),
        _buildLabel("التصنيف"),
        AppDropdownWidget(
          hintText: "اختر التصنيف",
          value: state.selectedCategory,
          itemsValues: ["PIECE", "KG", "G", "LITER", "ML", "BOX", "DOZEN", "METER"],
          errorText: state.Touched && (state.selectedCategory == null || state.selectedCategory!.isEmpty)
              ? "هذا الحقل مطلوب"
              : "",
          onChanged: controller.selectCategory,
        ),
        const SizedBox(height: 16),
        _buildLabel("اسم المنتج - عربي"),
        AppTextFieldWidget(
          hintText: "ادخل اسم المنتج",
          controller: nameArController,
          errorText: state.Touched && state.nameAr.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("اسم المنتج - EN"),
        AppTextFieldWidget(
          hintText: "ادخل اسم المنتج",
          controller: nameEnController,
          errorText: state.Touched && state.nameEn.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الحالة"),
        AppDropdownWidget(
          hintText: "اختر الحالة",
          value: state.selectedStatus,
          itemsValues: ["DRAFT", "PUBLISHED", "REJECTED"],
          errorText: state.Touched && (state.selectedStatus == null || state.selectedStatus!.isEmpty)
              ? "هذا الحقل مطلوب"
              : "",
          onChanged: controller.selectStatus,
        ),
        const SizedBox(height: 16),
        _buildLabel("الكمية"),
        AppTextFieldWidget(
          hintText: "ادخل الكمية",
          keyboardType: TextInputType.number,
          controller: quantityController,
          errorText: state.Touched && state.quantity.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("اقل عدد للطلب"),
        AppTextFieldWidget(
          hintText: "ادخل اقل قيمة",
          keyboardType: TextInputType.number,
          controller: minOrderController,
          errorText: state.Touched && state.minQty.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("السعر"),
        AppTextFieldWidget(
          hintText: "ادخل السعر",
          keyboardType: TextInputType.number,
          controller: priceController,
          errorText: state.Touched && state.price.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("عدد القطع"),
        AppTextFieldWidget(
          hintText: "ادخل عدد القطع",
          keyboardType: TextInputType.number,
          controller: stockQtyController,
          errorText: state.Touched && state.stockQty.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الوصف عربي"),
        AppTextFieldWidget(
          hintText: "ادخل الوصف",
          maxLines: 3,
          controller: descArController,
          errorText: state.Touched && state.descAr.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 16),
        _buildLabel("الوصف EN"),
        AppTextFieldWidget(
          hintText: "ادخل الوصف",
          maxLines: 3,
          controller: descEnController,
          errorText: state.Touched && state.descEn.trim().isEmpty ? "هذا الحقل مطلوب" : "",
        ),
        const SizedBox(height: 24),
        AppButtonWidget(
          label: "تم تسليم الطلب",
          onPressed: () async {

            final result = await controller.editProduct(productId);
            if(result is Left<Failure, Unit>){
              context.showMessage(message: "حدث خطأ .. لم يتم التعديل");

            }else{
              Navigator.pop(context, true);
              context.showMessage(message: "تم تعديل العنصر بنجاح");
            };

          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: StyleManager.getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
    );
  }
}