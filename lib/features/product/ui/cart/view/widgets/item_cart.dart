import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/cart/providers/cart_controller_provider.dart';

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
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        Text(
          '${product.price} ${Constants.currency}',
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
        final quantity = product.quantity;
        return Row(
          children: [
            Container(
              width: AppSize.s38,
              height: AppSize.s38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.pink.withOpacity(.10),
              ),
              alignment: Alignment.center,
              child: IconButton(
                onPressed: () => _onPressedDecreaseQuantity(ref),
                icon: const AppSvgPictureWidget(
                  assetName: AssetsManager.icMinus,
                  color: ColorManager.pink,
                ),
              ),
            ),
            Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: StyleManager.getSemiBoldStyle(
                color: ColorManager.blackColor,
                fontSize: FontSize.s16,
              ),
            ).marginSymmetric(
              horizontal: AppPadding.p4,
            ),
            Container(
              width: AppSize.s38,
              height: AppSize.s38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorManager.colorPrimary.withOpacity(.10),
              ),
              child: IconButton(
                onPressed: () => _onPressedIncreaseQuantity(ref),
                icon: const AppSvgPictureWidget(
                  assetName: AssetsManager.icAdd,
                  color: ColorManager.pink,
                ),
              ),
            ),
            const Gap(
              AppPadding.p4,
            ),
            IconButton(
              onPressed: () => _onPressedRemoveProduct(ref),
              icon: const Icon(
                Icons.delete,
              ),
            ),
          ],
        );
      },
    );
  }

  _onPressedDecreaseQuantity(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).decreaseProductToCart(product);
  }

  _onPressedIncreaseQuantity(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).increaseProductToCart(product);
  }

  _onPressedRemoveProduct(WidgetRef ref) {
    ref.read(cartControllerProvider.notifier).removeProductToCart(product);
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
