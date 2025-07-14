import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_category_model.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/providers/supplier_details_controller_provider.dart';

class ItemSupplierCategory extends ConsumerWidget {
  const ItemSupplierCategory({
    super.key,
    required this.category,
  });

  final SupplierCategoryModel category;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        onTap: () => _onPressedItemButton(ref),
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

  _onPressedItemButton(WidgetRef ref) {
    ref.read(supplierDetailsControllerProvider.notifier).changeCategory(category);
  }
}
