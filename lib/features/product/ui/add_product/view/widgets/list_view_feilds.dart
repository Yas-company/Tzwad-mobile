import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_text_field_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_ar_desc.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_en_desc.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_min_order_quantity_hook.dart';
import 'package:tzwad_mobile/features/product/ui/add_product/hooks/add_product_supplier_quantity_hook.dart';

import '../../../../../../core/app_widgets/app_drop_down_menu_widget.dart';
import '../../../../../../core/network/failure.dart';
import '../../../../../../core/resource/font_manager.dart';
import '../../../../../../core/resource/values_manager.dart';
import '../../../../../../core/util/state_render/result.dart';
import '../../../../../../core/util/unit.dart';
import '../../hooks/add_product_supplier_ar_name.dart';
import '../../hooks/add_product_supplier_en_name.dart';
import '../../hooks/add_product_supplier_pieces_hook .dart';
import '../../hooks/add_product_supplier_price_hook .dart';
import '../../providers/add_product_supplier_controller_provider.dart';

class ListViewFeilds extends HookConsumerWidget {
  const ListViewFeilds({super.key});

  @override
  Widget build(BuildContext context,ref) {
    final nameArController = useAddProductNameArController(ref: ref);
    final nameEnController = useAddProductNameEnController(ref: ref);
    final descArController = useAddProductDescArController(ref: ref);
    final descEnController = useAddProductDescEnController(ref: ref);
    final minOrderController = useAddProductMinOrderController(ref: ref);
    final piecesController = useAddProductPiecesController(ref: ref);
    final priceController = useAddProductPriceController(ref: ref);
    final quantityController = useAddProductQuantityController(ref: ref);

    final state = ref.watch(addProductControllerProvider);
    final controller = ref.read(addProductControllerProvider.notifier);
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.p24),
      children: [
        GestureDetector(
          onTap: () => controller.pickImage(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.imageFile != null
                  ? Image.file(state.imageFile!, width: double.infinity, fit: BoxFit.cover)
                  : Image.asset("assets/images/frame_image.png", width: double.infinity, fit: BoxFit.cover),
              if (state.imageFile == null && state.Touched)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text("الصورة مطلوبة", style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
            ],
          ),
        ),
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
          hintText: "ادخل العدد",
          keyboardType: TextInputType.number,
          controller: piecesController,
          errorText: state.Touched && state.pieces.trim().isEmpty ? "هذا الحقل مطلوب" : "",
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
            final result = await controller.submitProduct();
            if(result is Left<Failure, Unit>){
              context.showMessage(message: "حدث خطأ .. لم تتم الاضافة");

            }else{
              Navigator.pop(context, true);
              context.showMessage(message: 'تم اضافة عنصر بنجاح');
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