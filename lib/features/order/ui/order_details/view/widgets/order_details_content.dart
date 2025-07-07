import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/ui/orders_buyer/view/widgets/item_order.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/item_product.dart';

class OrderDetailsContent extends StatelessWidget {
  const OrderDetailsContent({
    super.key,
    required this.order,
    this.isLoading = false,
  });

  final OrderModel? order;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(AppPadding.p16),
            sliver: SliverToBoxAdapter(
              child: ItemOrder(
                order: order!,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppPadding.p12,
                mainAxisSpacing: AppPadding.p12,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => ItemProduct(
                  product: order!.items![index],
                  onPressedFavoriteButton: (_, __) {},
                  onPressedAddToCartButton: (_) {},
                ),
                childCount: order!.items?.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
