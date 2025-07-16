import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tzwad_mobile/core/app_widgets/app_image_asset_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/order/models/supplier_orders_response_model.dart';

class SupplierOrderWidget extends StatelessWidget {
  final SupplierOrdersData order;

  const SupplierOrderWidget({super.key, required this.order});

  Color get statusColor {
    final status = parseOrderStatus(order.status);

    switch (status) {
      case OrderStatus.completed:
        return Colors.green.shade100;
      case OrderStatus.inProgress:
        return Colors.amber.shade100;
      case OrderStatus.newOrder:
        return Colors.grey.shade300;
      case OrderStatus.canceled:
        return Colors.red;
      case OrderStatus.readyForOrder:
        return Colors.purple;
      case OrderStatus.Pending:
        return Colors.blue.shade100;
      default:
        return Colors.black;
    }
  }

  String get statusText {
    final status = parseOrderStatus(order.status);
    switch (status) {
      case OrderStatus.completed:
        return "مكتمل";
      case OrderStatus.inProgress:
        return "قيد التجهيز";
      case OrderStatus.newOrder:
        return "جديدة";
      case OrderStatus.canceled:
        return "ملغاة";
      case OrderStatus.readyForOrder:
        return "جاهزة للشحن";
      case OrderStatus.Pending:
        return "معلقة";
      default:
        return "قيد الانتظار";
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.white,elevation:0.2,
      margin: const EdgeInsets.only(bottom:8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(formatDateToArabic(order.createdAt??''), style:StyleManager.getMediumStyle(
                  fontSize: FontSize.s16,
                  color: ColorManager.colorBlack1,
                )),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top:3),
                    child: Text(
                      statusText,
                      style:StyleManager.getRegularStyle(
                        fontSize: FontSize.s14,
                        color: ColorManager.colorBlack1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: ColorManager.colorWhite3,),
            // Date and Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius:14, backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person,size:20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(order.buyerName??'',style:StyleManager.getMediumStyle(
                      fontSize: FontSize.s16,
                      color: ColorManager.colorBlack1,
                    ),),
                  ],
                ),
                Text(
                  order.shippingMethod.toString(),
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Time & Order #
            Text('${order.productsCount}'+' منتج ',style:StyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.colorWhite2,
            ),),
            const SizedBox(height: 6),

            Text('#${order.id}',style:StyleManager.getRegularStyle(
              fontSize: FontSize.s14,
              color: ColorManager.colorWhite2,
            ),),

            const SizedBox(height: 8),

            // Delivery Method

            const SizedBox(height: 8),

            // Order Details link
            InkWell(onTap:() {
              context.push(AppRoutes.orderSupplierDetailsView,extra:{
                'supplier_order_id':order.id??0
              });
            },child:  Text(
                "تفاصيل الطلب",
                style:StyleManager.getRegularStyle(
              fontSize: FontSize.s16,
              color: ColorManager.colorWhite2,
              decoration: TextDecoration.underline,
            )
              ),
            )
          ],
        ),
      ),
    );
  }
}


OrderStatus? parseOrderStatus(String? status) {
  return OrderStatus.values.firstWhere(
        (e) => e.name == status,
    orElse: () => OrderStatus.Pending, // or null if you prefer
  );
}

enum OrderStatus {
  completed,
  inProgress,
  newOrder,
  canceled,
  readyForOrder,
  Pending
}



String formatDateToArabic(String dateStr) {
  try {
    final dateTime = DateTime.parse(dateStr).toLocal();
    final formatter = DateFormat("d MMMM yyyy", "ar");
    return formatter.format(dateTime);
  } catch (e) {
    // You can also log the error if needed
    return dateStr;
  }
}
