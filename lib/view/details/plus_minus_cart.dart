import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../service/language_service.dart';
import '../../service/product_details_service.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_name.dart';

class PlusMinusCart extends StatelessWidget {
  void Function()? onTap;
  PlusMinusCart({this.onTap, Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: cc.pureWhite,
          ),
          height: 48,
          width: screenWidth / 3,
          child: Row(
            children: [
              Container(
                width: screenWidth / 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cc.pink.withOpacity(.10),
                ),
                child: IconButton(
                    onPressed: () {
                      Provider.of<ProductDetailsService>(context, listen: false)
                          .setQuantity(plus: false);
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icons/minus.svg',
                      color: cc.pink,
                    )),
              ),
              Expanded(
                  child: Text(
                Provider.of<ProductDetailsService>(context).quantity.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: cc.blackColor,
                    fontWeight: FontWeight.w600),
              )),
              Container(
                width: screenWidth / 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: cc.primaryColor.withOpacity(.10),
                ),
                child: IconButton(
                    onPressed: () {
                      Provider.of<ProductDetailsService>(context, listen: false)
                          .setQuantity();
                    },
                    icon: SvgPicture.asset(
                      'assets/images/icons/add.svg',
                      color: cc.primaryColor,
                    )),
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Stack(children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: cc.primaryColor,
              ),
              height: 48,
              width: screenWidth / 2.1,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/icons/bag.svg',
                    width: 20,
                  ),
                  // const SizedBox(width: 4),
                  SizedBox(
                    width: screenWidth / 5.2,
                    child: Text(
                      asProvider.getString('Add to cart'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: cc.pureWhite,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 3),
            Positioned(
              right: Provider.of<LanguageService>(context, listen: false).rtl
                  ? null
                  : 0,
              left: Provider.of<LanguageService>(context, listen: false).rtl
                  ? 0
                  : null,
              child: Container(
                height: 50,
                width: screenWidth / 5.3,
                color: cc.blackColor.withOpacity(.10),
                child: Center(
                  child: Consumer<LanguageService>(
                      builder: (context, lService, child) {
                    return Text(
                      lService.currencyRTL
                          ? '${(Provider.of<ProductDetailsService>(context).productSalePrice * Provider.of<ProductDetailsService>(context).quantity).toStringAsFixed(2)}${lService.currency}'
                          : '${lService.currency}${(Provider.of<ProductDetailsService>(context).productSalePrice * Provider.of<ProductDetailsService>(context).quantity).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13,
                        color: cc.pureWhite,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                ),
              ),
            )
          ]),
        )
      ],
    );
  }
}
