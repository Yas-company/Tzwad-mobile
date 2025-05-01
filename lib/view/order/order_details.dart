import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view/home/home_front.dart';
import '../../service/order_details_service.dart';
import '../../view/utils/constant_name.dart';
import '../../view/utils/text_themes.dart';
import '../../service/language_service.dart';
import '../../view/order/order_details_tile.dart';
import '../utils/app_bars.dart';
import '../utils/constant_styles.dart';

class OrderDetails extends StatelessWidget {
  final String tracker;
  bool? goHome;
  OrderDetails(this.tracker, {this.goHome = true, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderDetailsService>(context, listen: false)
        .fetchOrderDetails(tracker);
    // final tracker =
    // (ModalRoute.of(context)!.settings.arguments! as List)[0] as String;
    return Scaffold(
      appBar: AppBars().appBarTitled(context, tracker, () {
        if (goHome!) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeFront()),
              (Route<dynamic> route) => false);
          return;
        }
        Navigator.of(context).pop();
      }),
      body: WillPopScope(
        onWillPop: () async {
          if (goHome!) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeFront()),
                (Route<dynamic> route) => false);
            return true;
          }
          Navigator.of(context).pop();
          return true;
        },
        child: FutureBuilder(
            future: Provider.of<OrderDetailsService>(context, listen: false)
                .fetchOrderDetails(tracker),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting) {
                return loadingProgressBar();
              }
              if (!snapShot.hasData) {
                return Center(
                  child: Text(asProvider.getString('Failed to load data.')),
                );
              }
              return Consumer<OrderDetailsService>(
                  builder: (context, odService, child) {
                const titleTextTheme =
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 0
                              : 20,
                          right: Provider.of<LanguageService>(context,
                                      listen: false)
                                  .rtl
                              ? 20
                              : 0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            // padding: const EdgeInsets.all(10),
                            child: Text(
                              asProvider.getString('Image'),
                              style: titleTextTheme,
                            ),
                          ),
                          Container(
                            width: screenWidth / 3,
                            padding: EdgeInsets.only(
                                left: Provider.of<LanguageService>(context,
                                            listen: false)
                                        .rtl
                                    ? 0
                                    : 15,
                                right: Provider.of<LanguageService>(context,
                                            listen: false)
                                        .rtl
                                    ? 15
                                    : 0),
                            child: Text(
                              asProvider.getString('Name'),
                              style: titleTextTheme,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 70,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              asProvider.getString('Quantity'),
                              style: titleTextTheme,
                            ),
                          ),
                          // const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(10),
                            // alignment: Alignment.center,
                            child: Text(
                              asProvider.getString('Price'),
                              style: titleTextTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // if (odService.orderDetailsModel.product.length != 0)
                    odService.orderDetailsModel.product.isEmpty
                        ? Expanded(
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(asProvider.getString('Loading failed'))
                            ],
                          ))
                        : Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: const EdgeInsets.only(top: 10),
                              children: detailTileList(odService),
                            ),
                          ),
                    Container(
                      // height: 200,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        color: cc.whiteGrey,
                      ),
                      child: Column(children: [
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Subtotal'),
                              trailing: lService.currencyRTL
                                  ? '${odService.orderDetailsModel.orderInfo.paymentMeta!.subtotal}${lService.currency}'
                                  : '${lService.currency}${odService.orderDetailsModel.orderInfo.paymentMeta!.subtotal}');
                        }),
                        const SizedBox(height: 15),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Shipping'),
                              trailing: lService.currencyRTL
                                  ? '${odService.orderDetailsModel.orderInfo.paymentMeta!.shippingCost}${lService.currency}'
                                  : '${lService.currency}${odService.orderDetailsModel.orderInfo.paymentMeta!.shippingCost}');
                        }),
                        const SizedBox(height: 15),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Tax'),
                              trailing: lService.currencyRTL
                                  ? '${odService.orderDetailsModel.orderInfo.paymentMeta!.taxAmount}${lService.currency}'
                                  : '${lService.currency}${odService.orderDetailsModel.orderInfo.paymentMeta!.taxAmount}');
                        }),
                        const SizedBox(height: 15),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Discount'),
                              trailing: lService.currencyRTL
                                  ? '${odService.orderDetailsModel.orderInfo.paymentMeta!.couponAmount}${lService.currency}'
                                  : '${lService.currency}${odService.orderDetailsModel.orderInfo.paymentMeta!.couponAmount}');
                        }),
                        const SizedBox(height: 15),
                        const Divider(),
                        const SizedBox(height: 25),
                        Consumer<LanguageService>(
                            builder: (context, lService, child) {
                          return rows(asProvider.getString('Total'),
                              trailing: lService.currencyRTL
                                  ? '${odService.orderDetailsModel.orderInfo.paymentMeta!.total}${lService.currency}'
                                  : '${lService.currency}${odService.orderDetailsModel.orderInfo.paymentMeta!.total}');
                        }),
                        const SizedBox(height: 15),
                        rows(asProvider.getString('Payment status'),
                            trailing: (odService.orderDetailsModel.orderInfo
                                    .paymentStatus as String)
                                .capitalize()),
                      ]),
                    ),
                  ],
                );
              });
            }),
      ),
    );
  }

  List<Widget> detailTileList(OrderDetailsService odService) {
    List<Widget> list = [];
    odService.orderDetailsModel.product.forEach((ele) {
      final attributeItem = odService
          .orderDetailsModel.orderInfo.orderDetails[ele.id.toString()]!;
      attributeItem.forEach((element) {
        final price = element.attributes['price'];
        element.attributes.remove('price');
        element.attributes.remove('Color');
        element.attributes.remove('type');
        list.add(OrderDetailsTile(
            ele.title,
            price.toDouble(),
            element.quantity,
            ele.image,
            element.attributes.toString() == '{}'
                ? ''
                : ' (' + element.attributes.toString() + ') ',
            ele.id));
      });
    });

    return list;
    // return OrderDetailsTile(
    //     productItem.title,
    //     productItem.price.toDouble(),
    //     e.quantity,
    //     productItem.image,
    //     e.attributes.toString() == '{}'
    //         ? ''
    //         : ' (' + e.attributes.toString() + ') ',
    //     productItem.id);
  }

  Widget rows(String leading, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leading,
          style: TextThemeConstrants.paragraphText,
        ),
        if (trailing != null)
          Text(
            trailing,
            style: TextStyle(
                color: cc.greyParagraph,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
      ],
    );
  }
}
