import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/features/order/models/order_model.dart';
import 'package:tzwad_mobile/features/order/models/supplier_order_details_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/supplier_order_widget.dart';
import 'package:tzwad_mobile/features/order/ui/orders_buyer/view/widgets/item_order.dart';
import 'package:tzwad_mobile/features/product/ui/widgets/item_product.dart';

class SupplierOrderDetailsContentWidget extends StatelessWidget {
  const SupplierOrderDetailsContentWidget({
    super.key,
    required this.order,
    this.isLoading = false,
  });

  final SupplierOrder? order;
  final bool isLoading;
  Color get statusColor {
    final status = parseOrderStatus(order?.status??'');

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
    final status = parseOrderStatus(order?.status??'');
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
    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 16),
            _buildUserInfo(),
            const Divider(color: ColorManager.colorWhite3,),
            const SizedBox(height: 8),
            _buildAddressSection(),
            const SizedBox(height:20),
            const Divider(color: ColorManager.colorWhite3,),
            const Text(
              'تفاصيل الطلب',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...(order?.products??[]).map((item) => _buildOrderItem(item)),
            const Divider(color: ColorManager.colorWhite3,),
            const SizedBox(height:8),
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
               Text('السعر النهائي  ',
                   style: StyleManager.getMediumStyle(color:ColorManager.colorPrimary,
                       fontSize: AppSize.s16)
               ),
               Row(
                 children: [
                   Text(getTotalOrderPrice(order?.products??[]).toString(),
                       style: StyleManager.getBoldStyle(color:ColorManager.colorPrimary,
                           fontSize: AppSize.s16)
                   ),
                   const SizedBox(width:4,),
                   const Image(
                     image: AssetImage("assets/icons/ic_after_price.png"),
                     width: 9,color:ColorManager.colorPrimary,
                   ),
                 ],
               ),
             ],)
          ],
        ),
      )
    );
  }
  double getTotalOrderPrice(List<Products> products) {
    if(products.isEmpty){
      return 0;
    }
    return products.fold(0, (sum, p) {
      final price = double.tryParse(p.orderPrice ?? '0') ?? 0;
      return sum + price;
    });
  }
  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(formatDateToArabic(order?.createdAt??''), style:StyleManager.getMediumStyle(
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
    );
  }

  Widget _buildUserInfo() {
    return  Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:4),
          child: Row(
            children: [
              (order?.user?.image??'').isEmpty?
              CircleAvatar(
                radius:14, backgroundColor: Colors.grey[300],
                child: const Icon(Icons.person,size:20,
                  color: Colors.white,
                ),
              ):
              CircleAvatar(
                backgroundImage: NetworkImage(order?.user?.image??''),
              ),
              const SizedBox(width: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order?.user?.name??'',style:StyleManager.getMediumStyle(
                    fontSize: FontSize.s16,
                    color: ColorManager.colorBlack1,
                  ),),
                  Text('                                 '),
                  Text(
                    order?.orderDetail?.paymentMethod??'',
                    style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top:8,left:8,right:8),
          child: Text('${order?.productsCount}'+' منتج ',style:StyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.colorWhite2,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.only(top:0,left:8,right:8),
          child: Text('#${order?.id}#',style:StyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.colorWhite2,
          ),),
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'العنوان', style: StyleManager.getMediumStyle(
            fontSize: FontSize.s16,
            color: ColorManager.colorBlack1,
          ),
        ),
        const SizedBox(height: 6),
         Text(
           order?.orderDetail?.shippingAddress?.name??'',
          style:StyleManager.getRegularStyle(
            fontSize: FontSize.s14,
            color: ColorManager.colorWhite2,
          ),
        ),
        // TextButton(
        //   onPressed: () {},
        //   child: const Text('الخريطة', style: TextStyle(color: Colors.teal)),
        // )
      ],
    );
  }

  Widget _buildOrderItem(Products item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            item.image??'', width: 32,
            height: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:8),
              child: Text('${item.orderQuantity} x ${item.name}',style:
              StyleManager.getRegularStyle(color:ColorManager.colorBlack1,
                  fontSize: AppSize.s16),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8),
            child: Text('${item.price} ',style:
            StyleManager.getRegularStyle(color:ColorManager.colorBlack1,
                fontSize: AppSize.s16),),
          ),
        ],
      ),
    );
  }
}
