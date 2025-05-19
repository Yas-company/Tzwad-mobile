import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_network_image_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/constants.dart';
import 'package:tzwad_mobile/features/product/models/product_model.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppRippleWidget(
          onTap: () {},
          child: Row(
            children: [
              _buildImage().marginOnly(
                end: AppPadding.p4,
              ),
              Expanded(
                child: _buildNamePrice(),
              ),
              _buildQuantity(),
            ],
          ),
        ),
        //       const Spacer(),
        //       // Container(
        //       //   padding: const EdgeInsets.all(5),
        //       //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: cc.pureWhite, border: Border.all(width: .4, color: cc.greyTextFieldLebel)),
        //       //   height: 48,
        //       //   width: 105,
        //       //   child: Consumer<CartDataService>(builder: (context, cart, child) {
        //       //     return Row(
        //       //       children: [
        //       //         Container(
        //       //           height: 35,
        //       //           width: 35,
        //       //           decoration: BoxDecoration(
        //       //             borderRadius: BorderRadius.circular(10),
        //       //             color: cc.pink.withOpacity(0.10),
        //       //           ),
        //       //           child: IconButton(
        //       //               // padding: EdgeInsets.zero,
        //       //               onPressed: () {
        //       //                 cart.minusItem(id, context, inventorySet: inventorySet ?? {});
        //       //               },
        //       //               icon: SvgPicture.asset(
        //       //                 'assets/images/icons/minus.svg',
        //       //                 color: cc.pink,
        //       //               )),
        //       //         ),
        //       //         Expanded(
        //       //             child: Text(
        //       //           quantity.toString(),
        //       //           textAlign: TextAlign.center,
        //       //           style: TextStyle(fontSize: 15, color: cc.blackColor, fontWeight: FontWeight.w600),
        //       //         )),
        //       //         Container(
        //       //           height: 35,
        //       //           width: 35,
        //       //           decoration: BoxDecoration(
        //       //             borderRadius: BorderRadius.circular(10),
        //       //             color: cc.primaryColor.withOpacity(.10),
        //       //           ),
        //       //           child: IconButton(
        //       //               onPressed: () => cart.addItem(context, id, inventorySet: inventorySet ?? {}),
        //       //               icon: SvgPicture.asset(
        //       //                 'assets/images/icons/add.svg',
        //       //                 color: cc.primaryColor,
        //       //               )),
        //       //         ),
        //       //       ],
        //       //     );
        //       //   }),
        //       // ),
        //       // GestureDetector(
        //       //   onTap: (() async {
        //       //     bool deleteItem = false;
        //       //
        //       //     await confirmDialouge(context, onPressed: () => deleteItem = true);
        //       //     if (deleteItem) {
        //       //       snackBar(context, asProvider.getString('Item removed from cart.'), backgroundColor: cc.orange);
        //       //       carts.deleteCartItem(id, inventorySet: inventorySet ?? {});
        //       //     }
        //       //   }),
        //       //   child: Padding(
        //       //     padding: EdgeInsets.only(
        //       //       left: Provider.of<LanguageService>(context, listen: false).rtl ? 0 : 7,
        //       //       right: Provider.of<LanguageService>(context, listen: false).rtl ? 7 : 0,
        //       //     ),
        //       //     child: SvgPicture.asset(
        //       //       'assets/images/icons/trash.svg',
        //       //       height: 22,
        //       //       width: 22,
        //       //       color: const Color(0xffFF4065),
        //       //     ),
        //       //   ),
        //       // ),
        //     ],
        //   ),
        // ),
        const Divider(),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
        height: AppSize.s60,
        width: AppSize.s60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          //  const BorderRadius.only(
          //     topLeft: Radius.circular(10),
          //     topRight: Radius.circular(10)),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: product.image ?? '',
            placeholder: (context, url) => const AppImagePlaceHolderWidget(
              placeHolderEnum: PlaceHolderEnum.product,
            ),
            errorWidget: (context, url, error) => const AppImagePlaceHolderWidget(
              placeHolderEnum: PlaceHolderEnum.product,
            ),
          ),
        ));
  }

  Widget _buildNamePrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name ?? '',
          // style: StyleManager.getSemiBoldStyle(color: color),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ).marginOnly(
          bottom: AppPadding.p8,
        ),
        Text(
          '${product.price} ${Constants.currency}',
          style: StyleManager.getSemiBoldStyle(
            color: ColorManager.colorPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuantity() {
    return Row(
      children: [
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.colorPrimary.withOpacity(.10),
          ),
          child: const Icon(
            Icons.add,
            color: ColorManager.colorPrimary,
          ),
        ),
      ],
    );
  }
}
