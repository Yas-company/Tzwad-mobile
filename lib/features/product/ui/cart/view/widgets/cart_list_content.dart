import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

import 'item_cart.dart';

class CartListContent extends StatelessWidget {
  const CartListContent({
    super.key,
    required this.products,
    this.isLoading = false,
  });

  final List<ProductModel> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: ListView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) => ItemCart(
          product: products[index],
        ),
      ),
    );
  }
}
