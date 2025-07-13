import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';

class ItemSupplierCategory extends StatelessWidget {
  const ItemSupplierCategory({
    super.key,
    required this.category,
  });

  final SupplierCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s4),
        border: Border.all(
          color: category.isSelected ? ColorManager.colorSecondary : ColorManager.colorWhite5,
        ),
        color: category.isSelected ? ColorManager.colorSecondary.withAlpha(20) : ColorManager.colorWhite4,
      ),
      alignment: Alignment.center,
      child: AppRippleWidget(
        radius: AppSize.s4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
          child: Text(
            category.name ?? '',
            style: StyleManager.getRegularStyle(
              color: ColorManager.colorBlack1,
            ),
          ),
        ),
      ),
    );
  }
}
