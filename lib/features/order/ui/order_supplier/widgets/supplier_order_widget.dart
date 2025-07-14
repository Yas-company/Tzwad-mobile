import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';

class SupplierOrderWidget extends StatelessWidget {
  final OrderModel order;

  const SupplierOrderWidget({super.key, required this.order});

  Color get statusColor {
    switch (order.status) {
      case OrderStatus.completed:
        return Colors.green.shade100;
      case OrderStatus.inProgress:
        return Colors.amber.shade100;
      case OrderStatus.newOrder:
        return Colors.grey.shade300;
    }
  }

  String get statusText {
    switch (order.status) {
      case OrderStatus.completed:
        return "مكتمل";
      case OrderStatus.inProgress:
        return "قيد التجهيز";
      case OrderStatus.newOrder:
        return "جديدة";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Colors.white,elevation:0.2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(order.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                    // const AppImageAssetWidget(
                    //   imagePath: AssetsManager.icGoogle,
                    //   width: AppSize.s24,
                    //   height: AppSize.s24,
                    // ),
                    const SizedBox(width: 6),
                    Text(order.customerName),
                  ],
                ),
                Text(
                  order.deliveryMethod,
                  style: const TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Time & Order #
            Text('${order.orderCount}'+' منتج '),
            const SizedBox(height: 6),

            Text('#${order.orderNumber}'),

            const SizedBox(height: 8),

            // Delivery Method

            const SizedBox(height: 8),

            // Order Details link
            InkWell(onTap:() {
              context.push(AppRoutes.orderSupplierDetailsView);
            },child: const Text(
                "تفاصيل الطلب",
                style: TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


enum OrderStatus {
  completed,
  inProgress,
  newOrder,
}

class OrderModel {
  final String customerName;
  final String date;
  final String time;
  final String orderNumber;
  final int orderCount;
  final String deliveryMethod;
  final OrderStatus status;

  OrderModel({
    required this.customerName,
    required this.date,
    required this.time,
    required this.orderNumber,
    required this.orderCount,
    required this.deliveryMethod,
    required this.status,
  });
}
