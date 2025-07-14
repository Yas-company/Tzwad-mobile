import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import '../widgets/supplier_order_widget.dart';

class OrdersSupplierView extends StatelessWidget {
  const OrdersSupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      // appBar: AppBar(
      //   title: const Text('الطلبات'),
      // ),
      body:OrdersSupplierViewBody()
      // body: const OrdersViewBody(),
    );
  }
  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}


class OrdersSupplierViewBody extends StatelessWidget {
  const OrdersSupplierViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data
    final orders = [
      OrderModel(
        customerName: "محمد عبدالرحمن",
        date: "5 أغسطس 2025",
        time: "13",
        orderCount:14,
        orderNumber: "1029181",
        deliveryMethod: "الاستلام من الفرع",
        status: OrderStatus.completed,
      ),
      OrderModel(
        customerName: "محمد عبدالرحمن",
        date: "5 أغسطس 2025",
        time: "13",
        orderCount:8,
        orderNumber: "1029181",
        deliveryMethod: "التوصيل الى المنزل",
        status: OrderStatus.inProgress,
      ),
      OrderModel(
        customerName: "محمد عبدالرحمن",
        orderCount:10,
        date: "5 أغسطس 2025",
        time: "13",
        orderNumber: "1029181",
        deliveryMethod: "الاستلام من الفرع",
        status: OrderStatus.newOrder,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("سجل الطلبات"),centerTitle:false,),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          return SupplierOrderWidget(order: orders[index]);
        },
      ),
      floatingActionButton:  Container(height:50,
        margin: const EdgeInsets.only(bottom:14),
        child: FloatingActionButton.extended(
          onPressed: () {},backgroundColor: ColorManager.colorSecondary,
          label:Text('تصفية',style:StyleManager.getSemiBoldStyle(
            color: ColorManager.colorWhite1,
            fontSize: FontSize.s14,
          )),
          extendedIconLabelSpacing: 0,
          icon: const Icon(Icons.filter_list,color: ColorManager.colorWhite1),
        ),
      ),
    );
  }
}
