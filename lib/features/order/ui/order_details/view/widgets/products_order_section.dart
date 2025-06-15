import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/item_product.dart';

class ProductsOrderSection extends StatelessWidget {
  const ProductsOrderSection({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Consumer(
          builder: (context, ref, child) {
            return ItemProduct(
              product: products[index],
              onPressedFavoriteButton: (productId, value) => _onPressedFavoriteButton(ref, productId, value),
              onPressedAddToCartButton: (product) => _onPressedAddToCartButton(ref, product),
            );
          },
        ),
        itemCount: products.length,
        separatorBuilder: (BuildContext context, int index) => const Gap(AppPadding.p12),
      ),
    );
  }

  _onPressedFavoriteButton(WidgetRef ref, int productId, bool value) {}

  _onPressedAddToCartButton(WidgetRef ref, ProductModel product) {}
}
