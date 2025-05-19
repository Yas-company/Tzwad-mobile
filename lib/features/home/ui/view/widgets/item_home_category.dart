import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/category/models/category_model.dart';

class ItemHomeCategory extends StatelessWidget {
  const ItemHomeCategory({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return AppRippleWidget(
      radius: AppSize.s8,
      onTap: () => _onPressedItemButton(context),
      child: Container(
        alignment: Alignment.center,
        width: AppSize.s160,
        margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.p6,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.s8),
          border: Border.all(
            color: ColorManager.borderColor,
          ),
          color: ColorManager.colorPureWhite,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                height: 37,
                width: 37,
                imageUrl: category.image ?? '',
                placeholder: (context, url) => const Icon(Icons.category),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
            ).marginOnly(
              end: AppPadding.p4,
            ),

            //Title
            Flexible(
              child: Text(
                category.name ?? '',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: StyleManager.getRegularStyle(
                  color: ColorManager.greyParagraph,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPressedItemButton(BuildContext context) {
    context.pushNamed(
      AppRoutes.productsRoute,
      extra: {
        'category_id': category.id,
      },
    );
  }
}
