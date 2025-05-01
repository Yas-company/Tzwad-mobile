import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';
import '../../view/order/order_details.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';

class OrderTile extends StatelessWidget {
  final double totalAmount;
  final String trackingCode;
  final DateTime orderedDate;
  final String? delivered;
  OrderTile(
    this.totalAmount,
    this.trackingCode,
    this.orderedDate,
    this.delivered, {
    Key? key,
  }) : super(key: key);
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    return SizedBox(
      height: screenHight / 10 < 82 ? 82 : screenHight / 10,
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        style: ListTileStyle.drawer,
        visualDensity: const VisualDensity(vertical: -3),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute<void>(
            builder: (BuildContext context) => OrderDetails(
              trackingCode,
              goHome: false,
            ),
          ));
        },
        title: Consumer<LanguageService>(builder: (context, lService, child) {
          return Text(
            lService.currencyRTL
                ? '${totalAmount.toStringAsFixed(2)}${lService.currency}'
                : '${lService.currency}${totalAmount.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          );
        }),
        subtitle: Row(
          children: [
            Text(
              trackingCode,
              style: TextStyle(
                  color: cc.primaryColor, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat.yMMMd().format(orderedDate),
              style: TextStyle(color: cc.greyHint),
            )
          ],
        ),
        trailing: SizedBox(
          width: screenWidth / 2.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: screenWidth / 4,
                height: 20,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: delivered == 'complete' ? cc.primaryColor : cc.orange,
                ),
                child: FittedBox(
                  child: Text(
                    delivered
                        .toString()
                        .replaceAll('Status.', ' ')
                        .replaceAll('_', ' ')
                        .capitalize(),
                    style: TextStyle(color: cc.pureWhite),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
