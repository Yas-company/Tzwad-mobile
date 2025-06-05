import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: ColorManager.borderColor,
        ),
        color: ColorManager.colorPureWhite,
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => _onPressedItem(context),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Order #${order.id}',
                      style: StyleManager.getBoldStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s16,
                      ),
                    ).marginOnly(
                      bottom: AppPadding.p4,
                    ),
                    Text(
                      'Total: ${order.totalAmount} ${Constants.currency}',
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.blackColor,
                        fontSize: FontSize.s12,
                      ),
                    ).marginOnly(
                      bottom: AppPadding.p4,
                    ),
                    Text(
                      'Order Date: ${order.createdAt.getFormatDash()}',
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.greyHint,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ],
                ),
              ),
              Skeleton.shade(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p2,
                    horizontal: AppPadding.p8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: getStatusColor(order.status ?? ''),
                  ),
                  child: FittedBox(
                    child: Text(
                      order.status ?? '',
                      style: StyleManager.getRegularStyle(
                        color: ColorManager.colorPureWhite,
                      ),
                      // delivered.toString().replaceAll('Status.', ' ').replaceAll('_', ' ').capitalize(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return ColorManager.grey; // neutral, waiting
      case 'accepted':
        return ColorManager.blue; // info, approved
      case 'rejected':
        return ColorManager.red; // error
      case 'paid':
        return ColorManager.green; // success
      case 'shipped':
        return ColorManager.indigo; // in transit
      case 'delivered':
        return ColorManager.teal; // completed
      case 'cancelled':
        return ColorManager.rose; // cancelled/soft error
      default:
        return ColorManager.colorPrimary;
    }
  }

  _onPressedItem(BuildContext context) {
    context.pushNamed(
      AppRoutes.orderDetailsRoute,
      extra: {
        'order_id': order.id,
      },
    );
  }
}
