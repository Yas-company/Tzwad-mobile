import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';
import 'package:tzwad_mobile/features/product/ui/cart/view/widgets/remove_product_dialog.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppRippleWidget(
          onTap: () => _onPressedItem(context),
          child: Row(
            children: [
              _buildImage(),
              const Gap(
                AppPadding.p4,
              ),
              Expanded(
                child: _buildNamePrice(),
              ),
              const Gap(
                AppPadding.p4,
              ),
              _buildQuantity(),
              const Gap(
                AppPadding.p4,
              ),
              IconButton(
                onPressed: () => _onPressedRemoveProduct(context),
                icon: const Icon(
                  Icons.delete,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      height: AppSize.s60,
      width: AppSize.s60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: product.image ?? '',
          placeholder: (context, url) => const AppImagePlaceHolderWidget(
            placeHolderEnum: PlaceHolderEnum.product,
          ),
          errorWidget: (context, url, error) => const AppImagePlaceHolderWidget(
            placeHolderEnum: PlaceHolderEnum.product,
          ),
        ),
      ),
    );
  }

  Widget _buildNamePrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.blackColor,
            fontSize: FontSize.s16,
          ).copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        Text(
          '${(double.tryParse((product.price ?? '0')) ?? 0) * (product.cartQuantity ?? 0)} ${Constants.currency}',
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.colorPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Consumer(
      builder: (context, ref, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (product.isLoading) ...{
              const AppLoadingWidget(
                color: ColorManager.colorPrimary,
              )
            } else ...{
              DropdownButton<int>(
                items: [
                  for (int i = 0; i < 100; i++)
                    DropdownMenuItem(
                      value: i + 1,
                      child: Text(
                        '${i + 1}',
                        style: StyleManager.getSemiBoldStyle(
                          color: ColorManager.colorPrimary,
                        ),
                      ),
                    ),
                ],
                onChanged: (value) {
                  ref.read(cartControllerProvider.notifier).updateQuantityForProduct(product, value ?? 0);
                },
                value: product.cartQuantity ?? 0,
              ),
            },
          ],
        );
      },
    );
  }

  _onPressedRemoveProduct(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: RemoveProductDialog(
          product: product,
        ),
      ),
    );
  }

  _onPressedItem(BuildContext context) {
    context.pushNamed(
      AppRoutes.productDetailsRoute,
      extra: {
        'id': product.id,
      },
    );
  }
}
