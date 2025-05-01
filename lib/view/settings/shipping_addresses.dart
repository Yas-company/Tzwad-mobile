import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../view/settings/new_address.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import '../../view/utils/constant_styles.dart';
import 'package:provider/provider.dart';

import '../../service/shipping_addresses_service.dart';

class ShippingAdresses extends StatefulWidget {
  static const routeName = 'shipping addresses';
  const ShippingAdresses({Key? key}) : super(key: key);

  @override
  State<ShippingAdresses> createState() => _ShippingAdressesState();
}

class _ShippingAdressesState extends State<ShippingAdresses> {
  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars().appBarTitled(
          context, asProvider.getString('Shipping addresses'), () {
        Navigator.of(context).pop();
      }),
      body: Column(
        children: [
          Expanded(
            child: Provider.of<ShippingAddressesService>(context)
                    .shippingAddresseList
                    .isEmpty
                ? (Provider.of<ShippingAddressesService>(context).noData
                    ? Center(
                        child: Text(
                          asProvider.getString('No address added yet!'),
                          style: TextStyle(color: cc.greyHint),
                        ),
                      )
                    : loadingProgressBar())
                : ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      const SizedBox(height: 25),
                      ...Provider.of<ShippingAddressesService>(context)
                          .shippingAddresseList
                          .map(((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: addressBox(e.name, e.address, e.id),
                              ))),
                    ],
                  ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: customContainerButton(
                  asProvider.getString('Add new address'), double.infinity, () {
                Navigator.of(context).pushNamed(AddNewAddress.routeName);
              })),
          const SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget addressBox(
    String addressTile,
    String address,
    int id,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: cc.whiteGrey,
          border: Border.all(color: cc.greyHint, width: .5)),
      child: Stack(children: [
        ListTile(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(addressTile),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Text(address),
          ),
          trailing: GestureDetector(
              onTap: (() {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text(asProvider.getString('Are you sure?')),
                          content: Text(asProvider.getString(
                              'This address will be deleted permanently.')),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        cc.primaryColor),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(asProvider.getString('No')),
                            ),
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        cc.primaryColor),
                              ),
                              onPressed:
                                  Provider.of<ShippingAddressesService>(context)
                                          .alertBoxLoading
                                      ? () {}
                                      : (() async {
                                          Provider.of<ShippingAddressesService>(
                                                  context,
                                                  listen: false)
                                              .setAlertBoxLoading(true);
                                          await Provider.of<
                                                      ShippingAddressesService>(
                                                  context,
                                                  listen: false)
                                              .deleteSingleAddress(id);

                                          Provider.of<ShippingAddressesService>(
                                                  context,
                                                  listen: false)
                                              .setAlertBoxLoading(false);
                                          Navigator.pop(context);
                                        }),
                              child:
                                  Provider.of<ShippingAddressesService>(context)
                                          .alertBoxLoading
                                      ? SizedBox(
                                          height: 20,
                                          width: 40,
                                          child: loadingProgressBar(size: 15))
                                      : Text(
                                          asProvider.getString('Yes'),
                                          style: TextStyle(color: cc.pink),
                                        ),
                            ),
                            // FlatButton(
                            //     onPressed:
                            //         Provider.of<ShippingAddressesService>(
                            //                     context)
                            //                 .alertBoxLoading
                            //             ? () {}
                            //             : (() async {
                            //                 Provider.of<ShippingAddressesService>(
                            //                         context,
                            //                         listen: false)
                            //                     .setAlertBoxLoading(true);
                            //                 await Provider.of<
                            //                             ShippingAddressesService>(
                            //                         context,
                            //                         listen: false)
                            //                     .deleteSingleAddress(id);

                            //                 Provider.of<ShippingAddressesService>(
                            //                         context,
                            //                         listen: false)
                            //                     .setAlertBoxLoading(false);
                            //                 Navigator.pop(context);
                            //               }),
                            //     child: Provider.of<ShippingAddressesService>(
                            //                 context)
                            //             .alertBoxLoading
                            //         ? SizedBox(
                            //             height: 20,
                            //             width: 40,
                            //             child: loadingProgressBar(size: 15))
                            //         : Text(
                            //             'Yes',
                            //             style: TextStyle(color: cc.pink),
                            //           ))
                          ],
                        ));
              }),
              child: SvgPicture.asset(
                'assets/images/icons/trash.svg',
                height: 22,
                width: 22,
                color: cc.pink,
              )),
        ),
      ]),
    );
  }
}
