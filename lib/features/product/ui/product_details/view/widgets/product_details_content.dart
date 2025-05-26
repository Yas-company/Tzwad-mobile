import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

import 'product_additional_information.dart';
import 'product_description.dart';
import 'product_details_app_bar_widget.dart';

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({
    super.key,
    required this.product,
    required this.isLoading,
  });

  final ProductModel? product;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => _onPressedBackButton(context),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            pinned: true,
            expandedHeight: AppSize.s220,
            flexibleSpace: FlexibleSpaceBar(
              background: ProductDetailsAppBarWidget(
                url: product?.image ?? '',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppPadding.p16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    product?.name ?? '',
                    style: StyleManager.getBoldStyle(
                      color: ColorManager.blackColor,
                      fontSize: FontSize.s20,
                    ),
                  ).marginOnly(
                    bottom: AppPadding.p8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        TextSpan(
                          text: '${product?.priceBeforeDiscount} ${Constants.currency} ',
                          style: StyleManager.getSemiBoldStyle(
                            color: ColorManager.colorPrimary,
                            fontSize: FontSize.s14,
                          ),
                          children: [
                            TextSpan(
                              text: '${product?.price} ${Constants.currency}',
                              style: StyleManager.getRegularStyle(
                                color: ColorManager.cardGreyHint,
                                fontSize: FontSize.s14,
                              ).copyWith(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: ColorManager.cardGreyHint,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        stockStatus(product?.stockQty),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: StyleManager.getSemiBoldStyle(
                          color: ColorManager.colorPrimary,
                          fontSize: FontSize.s14,
                        ),
                      ),
                    ],
                  ).marginOnly(
                    bottom: AppPadding.p16,
                  ),
                  ProductDescription(
                    description: product?.description ?? '',
                  ).marginOnly(
                    bottom: AppPadding.p16,
                  ),
                  ProductAdditionalInformation(
                    info: Faker().lorem.sentence() + Faker().lorem.sentence() + Faker().lorem.sentence(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }

  String stockStatus(int? quantity) {
    if (quantity != null && quantity > 0) {
      return 'In Stock($quantity)';
    } else {
      return 'Out of Stock($quantity)';
    }
  }
}
