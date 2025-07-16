import 'package:flutter/material.dart';
import 'package:tzwad_mobile/features/order/models/supplier_orders_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/supplier_order_widget.dart';

class LoadingSupplierOrderWidget extends StatelessWidget {
  const LoadingSupplierOrderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SupplierOrderWidget(order: SupplierOrdersData());
  }
}
