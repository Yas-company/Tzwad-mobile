import 'package:flutter/material.dart';
import 'package:gren_mart/service/order_list_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:gren_mart/view/utils/constant_styles.dart';
import '../../view/order/order_tile.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatelessWidget {
  MyOrders({Key? key}) : super(key: key);
  ConstantColors cc = ConstantColors();
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    controller.addListener((() => scrollListener(context)));
    return Scaffold(
      appBar: AppBars().appBarTitled(context, asProvider.getString('My orders'),
          () {
        Navigator.of(context).pop();
      }),
      body: FutureBuilder(
          future: Provider.of<OrderListService>(context, listen: false)
              .fetchOrderList(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingProgressBar();
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(asProvider.getString('Failed to load data.')),
              );
            }

            return Consumer<OrderListService>(
                builder: (context, oService, child) {
              if (oService.noOrder) {
                return Center(
                  child: Text(asProvider.getString('No order found.')),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      controller: controller,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: oService.orderListModel!.data.length,
                      itemBuilder: (context, index) {
                        final element = oService.orderListModel!.data[index];
                        return OrderTile(
                          double.parse(element.totalAmount),
                          '#${element.orderId}',
                          element.createdAt,
                          element.status,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ),
                  ),
                  if (oService.loadingNextPage)
                    Center(child: loadingProgressBar()),
                ],
              );
            });
          })),
    );
  }

  scrollListener(BuildContext context) {
    final oService = Provider.of<OrderListService>(context, listen: false);
    final orderListData = oService.orderListModel;

    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      if (orderListData!.nextPageUrl != null && !oService.loadingNextPage) {
        oService.setLodingNextPage(true);
        oService
            .fetchNextPage()
            .then((value) => oService.setLodingNextPage(false))
            .onError((error, stackTrace) => oService.setLodingNextPage(false));
      } else {
        snackBar(context, asProvider.getString('No more order found'),
            backgroundColor: cc.orange);
      }
    }
  }

  Future<bool> showTimout() async {
    await Future.delayed(const Duration(seconds: 10));
    return true;
  }
}
