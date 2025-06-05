import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/order/models/order_type_enum.dart';
import 'package:tzwad_mobile/features/order/ui/orders/providers/orders_controller_provider.dart';

class OrdersFilterSection extends ConsumerWidget {
  const OrdersFilterSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderType = ref.watch(
      ordersControllerProvider.select(
        (value) => value.orderType,
      ),
    );
    final filters = OrderTypeEnum.values;

    return SizedBox(
      height: AppSize.s40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        separatorBuilder: (context, index) => const Gap(AppPadding.p8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = orderType == filter;
          return AppRippleWidget(
            onTap: () {
              ref.read(ordersControllerProvider.notifier).getOrders(orderType: filter);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              decoration: BoxDecoration(
                color: isSelected ? ColorManager.colorPrimary1 : ColorManager.colorPureWhite,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Text(
                filter.value.isEmpty ? 'ALL' : filter.value.toUpperCase(),
              ),
            ),
          );
        },
      ),
    );
  }
}
