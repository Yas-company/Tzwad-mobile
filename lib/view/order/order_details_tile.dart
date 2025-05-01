import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view/utils/constant_name.dart';
import '../../service/language_service.dart';
import '../../view/utils/constant_colors.dart';
import '../details/product_details.dart';

class OrderDetailsTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final double price;
  final int quantity;
  final dynamic id;

  OrderDetailsTile(
      this.title, this.price, this.quantity, this.image, this.subTitle, this.id,
      {Key? key})
      : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    print(subTitle);
    String subtitle1 = subTitle.replaceAll('{', '');
    final subtitle2 = subtitle1.replaceAll('}', '');
    print(subtitle2);
    return SizedBox(
      // height: 75,
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetails.routeName, arguments: [id]);
            },
            contentPadding: EdgeInsets.only(
                left: Provider.of<LanguageService>(context, listen: false).rtl
                    ? 0
                    : 20,
                right: Provider.of<LanguageService>(context, listen: false).rtl
                    ? 20
                    : 0),
            leading: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
            title: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      if (subtitle2.trim() != '()') const SizedBox(height: 5),
                      if (subtitle2.trim() != '()')
                        Text(
                          subtitle2,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 11,
                            color: cc.greyParagraph,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 7),
                SizedBox(
                  width: 67,
                  child: Text(
                    'x$quantity',
                    style: TextStyle(
                        color: cc.greyHint,
                        fontWeight: FontWeight.w600,
                        fontSize: 12),
                  ),
                ),
                // const Spacer(),
                SizedBox(
                  child: Consumer<LanguageService>(
                      builder: (context, lService, child) {
                    return Text(
                      lService.currencyRTL
                          ? '${price.toStringAsFixed(2)}${lService.currency}'
                          : '${lService.currency}${price.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: cc.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    );
                  }),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
