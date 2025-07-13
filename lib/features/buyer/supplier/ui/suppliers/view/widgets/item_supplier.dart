import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/buyer/supplier/models/supplier_model.dart';

import 'supplier_rating_widget.dart';

class ItemSupplier extends StatelessWidget {
  const ItemSupplier({
    super.key,
    required this.supplier,
  });

  final SupplierModel supplier;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: ColorManager.colorWhite5,
        ),
        color: ColorManager.colorWhite4,
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => _onPressedItemButton(context),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
                child: AppImageAssetWidget(
                  imagePath: 'assets/images/img_temp.png',
                  width: AppSize.s60,
                  height: AppSize.s60,
                ),
              ).marginOnly(
                end: AppPadding.p16,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            supplier.name ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: StyleManager.getMediumStyle(
                              color: ColorManager.colorBlack1,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ),
                        SupplierRatingWidget(
                          rating: supplier.rating ?? 0.0,
                        ),
                      ],
                    ).marginOnly(
                      bottom: AppPadding.p4,
                      
                    ),
                    Text(
                      fieldsName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.colorWhite2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressedItemButton(BuildContext context) {
    context.pushNamed(
      AppRoutes.supplierDetailsRoute,
      extra: {
        'supplier_id': supplier.id,
        'supplier_name': supplier.name,
        'supplier_image': supplier.image,
      },
    );
  }

  String get fieldsName => supplier.fields?.map((e) => e.name).join(', ') ?? '';
}
