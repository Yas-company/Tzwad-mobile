import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status badge
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
            const SizedBox(height: 8),

            // Date and Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(order.date, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(order.customerName),
                    const SizedBox(width: 6),
                    const CircleAvatar(radius: 12, backgroundImage: AssetImage('assets/avatar.png')), // or NetworkImage
                  ],
                ),
              ],
            ),

            const SizedBox(height: 6),

            // Time & Order #
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${order.time} دقيقة'),
                Text('#${order.orderNumber}'),
              ],
            ),

            const SizedBox(height: 8),

            // Delivery Method
            Text(
              order.deliveryMethod,
              style: const TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Order Details link
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
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
  final String deliveryMethod;
  final OrderStatus status;

  OrderModel({
    required this.customerName,
    required this.date,
    required this.time,
    required this.orderNumber,
    required this.deliveryMethod,
    required this.status,
  });
}
