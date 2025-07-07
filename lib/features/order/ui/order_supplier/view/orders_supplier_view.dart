import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

class OrdersSupplierView extends StatelessWidget {
  const OrdersSupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back_ios),
        //   onPressed: () => _onPressedBackButton(context),
        // ),
        title: const Text('الطلبات'),
      ),
      body: const Center(
        child: Text('Orders'),
      ),
      // body: const OrdersViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
