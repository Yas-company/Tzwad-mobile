import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/view/cart/checkout.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import 'package:provider/provider.dart';

import '../auth/custom_text_field.dart';
import '../utils/constant_styles.dart';
import '../../service/shipping_addresses_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import '../../service/country_dropdown_service.dart';
import '../../service/state_dropdown_service.dart';
import '../utils/country_dropdown.dart';
import '../utils/state_dropdown.dart';

class AddNewAddress extends StatelessWidget {
  static const routeName = 'add new address';
  bool dontPop;
  AddNewAddress({Key? key, this.dontPop = false}) : super(key: key);

  ConstantColors cc = ConstantColors();

  final GlobalKey<FormState> _formKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  final _emailFN = FocusNode();
  final _phonelFN = FocusNode();
  final _cityFN = FocusNode();
  final _zipCodeFN = FocusNode();
  final _addressFN = FocusNode();

  Future _onSubmit(
      BuildContext context, ShippingAddressesService saData) async {
    final validated = _formKey.currentState!.validate();
    if (!validated || saData.phone == null) {
      snackBar(context,
          asProvider.getString("Please give all the information properly"),
          backgroundColor: cc.orange);
      scrollController.animateTo(0.0,
          curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
      return;
    }
    saData.setIsLoading(true);
    saData.addShippingAddress().then((value) {
      if (value == null) {
        saData.fetchUsersShippingAddress(context);
        Navigator.of(context).pop();
        if (dontPop) {
          Navigator.of(context).pushNamed(Checkout.routeName);
          return;
        }
        saData.setIsLoading(false);
        return;
      }
      snackBar(context, value, backgroundColor: cc.orange);
      saData.setIsLoading(false);
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<CountryDropdownService>(context, listen: false)
    //     .getContries(context);
    return Scaffold(
      appBar: AppBars()
          .appBarTitled(context, asProvider.getString('Add New Address'), () {
        if (dontPop) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(Checkout.routeName);
          return;
        }

        Navigator.of(context).pop();
      }, hasButton: true),
      body: WillPopScope(
        onWillPop: () async {
          print(dontPop);
          if (dontPop) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(Checkout.routeName);
            return false;
          }
          return true;
        },
        child: Consumer<ShippingAddressesService>(
            builder: (context, saData, child) {
          return ListView(
            controller: scrollController,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            children: [
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textFieldTitle(asProvider.getString('Name')),
                        // const SizedBox(height: 8),
                        CustomTextField(
                          asProvider.getString('Enter name'),
                          validator: (nameText) {
                            if (nameText!.isEmpty) {
                              return asProvider.getString('Enter address name');
                            }
                            if (nameText.length <= 3) {
                              return asProvider
                                  .getString('Enter more then 3 character');
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_emailFN);
                          },
                          onChanged: (value) {
                            saData.setName(value);
                          },
                          // imagePath: 'assets/images/icons/mail.png',
                        ),

                        textFieldTitle(asProvider.getString('Email')),
                        // const SizedBox(height: 8),
                        CustomTextField(
                          asProvider.getString('Enter email address'),
                          focusNode: _emailFN,
                          validator: (emailText) {
                            if (emailText!.isEmpty) {
                              return asProvider.getString('Enter your email');
                            }
                            if (!EmailValidator.validate(emailText)) {
                              return asProvider
                                  .getString('Enter a valid email');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            saData.setEmail(value);
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_phonelFN);
                          },
                          // imagePath: 'assets/images/icons/mail.png',
                        ),
                        textFieldTitle(asProvider.getString('Phone Number')),
                        CustomTextField(
                          asProvider.getString('Enter Phone number'),
                          keyboardType: TextInputType.number,
                          validator: (emailText) {
                            if (emailText!.isEmpty) {
                              return asProvider.getString('Enter your number');
                            }

                            return null;
                          },
                          onChanged: (value) {
                            saData.setPhone(value);
                          },
                        ),
                        // IntlPhoneField(
                        //   focusNode: _phonelFN,
                        //   style: TextThemeConstrants.greyHint13,
                        //   keyboardType: TextInputType.number,
                        //   initialCountryCode: 'BD',
                        //   decoration: InputDecoration(
                        //     hintText: 'Enter your number',
                        //     hintStyle: TextStyle(
                        //         color: cc.greyTextFieldLebel, fontSize: 13),
                        //     contentPadding: const EdgeInsets.symmetric(
                        //         horizontal: 8, vertical: 17),
                        //     border: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(10),
                        //         borderSide:
                        //             BorderSide(color: cc.greyHint, width: 2)),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:
                        //           BorderSide(color: cc.primaryColor, width: 2),
                        //     ),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:
                        //           BorderSide(color: cc.greyBorder, width: 1),
                        //     ),
                        //     errorBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //       borderSide:
                        //           BorderSide(color: cc.orange, width: 1),
                        //     ),
                        //   ),
                        //   onChanged: (phone) {
                        //     saData.setPhone(phone.number);
                        //     print(phone.number);
                        //   },
                        //   onCountryChanged: (country) {
                        //     saData.setCountryCode(country.code);
                        //     print('Country changed to: ' + country.code);
                        //   },
                        //   onSubmitted: (_) {
                        //     FocusScope.of(context).requestFocus(_cityFN);
                        //   },
                        // ),

                        textFieldTitle(asProvider.getString('Country')),
                        Consumer<CountryDropdownService>(
                          builder: (context, cProvider, child) =>
                              CountryDropdown(
                            hintText: "Select Country",
                            textStyle: TextStyle(color: cc.greyHint),
                            iconColor: cc.greyHint,
                            selectedValue: cProvider.selectedCountry,
                            onChanged: (newValue) {
                              cProvider.setCountryIdAndValue(newValue, context);
                              saData.setCountryId(
                                  cProvider.selectedCountryId.toString());
                              // Provider.of<StateDropdownService>(context,
                              //         listen: false)
                              //     .getStates(cProvider.selectedCountryId)
                              //     .then((value) {
                              //   saData.setStateId(
                              //       Provider.of<StateDropdownService>(context,
                              //               listen: false)
                              //           .selectedStateId
                              //           .toString());
                              // });
                            },
                            textFieldHint: "Search Country",
                          ),
                        ),
                        // const SizedBox(height: 8),
                        // Consumer<CountryDropdownService>(
                        //   builder: (context, cProvider, child) => cProvider
                        //           .countryDropdownList.isNotEmpty
                        //       ? CustomDropdown(
                        //           asProvider.getString('Country'),
                        //           cProvider.countryDropdownList,
                        //           (newValue) {
                        //             cProvider.setCountryIdAndValue(newValue);
                        //             saData.setCountryId(
                        //                 cProvider.selectedCountryId.toString());
                        //             Provider.of<StateDropdownService>(context,
                        //                     listen: false)
                        //                 .getStates(cProvider.selectedCountryId)
                        //                 .then((value) {
                        //               saData.setStateId(
                        //                   Provider.of<StateDropdownService>(
                        //                           context,
                        //                           listen: false)
                        //                       .selectedStateId
                        //                       .toString());
                        //             });
                        //           },
                        //           value: cProvider.selectedCountry,
                        //         )
                        //       : SizedBox(
                        //           height: 10,
                        //           child: Center(
                        //             child: FittedBox(
                        //               child: CircularProgressIndicator(
                        //                 color: cc.greyHint,
                        //               ),
                        //             ),
                        //           )),
                        // ),
                        Consumer<CountryDropdownService>(
                            builder: (context, cProvider, child) => cProvider
                                        .selectedCountry !=
                                    null
                                ? textFieldTitle(asProvider.getString('State'))
                                : SizedBox()),
                        Consumer<CountryDropdownService>(
                            builder: (context, cProvider, child) =>
                                cProvider.selectedCountry != null
                                    ? Consumer<StateDropdownService>(
                                        builder: ((context, sProvider, child) =>
                                            StateDropdown(
                                              hintText: "Select State",
                                              textStyle:
                                                  TextStyle(color: cc.greyHint),
                                              iconColor: cc.greyHint,
                                              selectedValue:
                                                  sProvider.selectedState,
                                              onChanged: (newValue) {
                                                sProvider.setStateIdAndValue(
                                                    newValue);
                                                saData.setStateId(sProvider
                                                    .selectedStateId
                                                    .toString());
                                              },
                                              textFieldHint: "Search State",
                                            )))
                                    : SizedBox()),
                        // textFieldTitle(asProvider.getString('State')),
                        // Consumer<StateDropdownService>(
                        //     builder: ((context, sModel, child) => (sModel
                        //             .isLoading
                        //         ? SizedBox(
                        //             height: 10,
                        //             child: Center(
                        //               child: FittedBox(
                        //                 child: CircularProgressIndicator(
                        //                   color: cc.greyHint,
                        //                 ),
                        //               ),
                        //             ))
                        //         : CustomDropdown(
                        //             asProvider.getString('State'),
                        //             sModel.stateDropdownList,
                        //             (newValue) {
                        //               sModel.setStateIdAndValue(newValue);
                        //               saData.setStateId(
                        //                   sModel.selectedStateId.toString());
                        //             },
                        //             value: sModel.selectedState,
                        //           )))),
                        textFieldTitle(asProvider.getString('City')),
                        // const SizedBox(height: 8),
                        CustomTextField(
                          asProvider.getString('Enter your city'),
                          validator: (cityText) {
                            if (cityText!.isEmpty) {
                              return asProvider.getString('Enter your city');
                            }
                            if (cityText.length <= 2) {
                              return asProvider.getString('Enter a valid city');
                            }
                            return null;
                          },
                          focusNode: _cityFN,
                          onChanged: (value) {
                            saData.setCity(value);
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_zipCodeFN);
                          },
                          // imagePath: 'assets/images/icons/mail.png',
                        ),
                        textFieldTitle(asProvider.getString('Zip code')),
                        // const SizedBox(height: 8),
                        CustomTextField(
                          asProvider.getString('Enter zip code'),
                          focusNode: _zipCodeFN,
                          keyboardType: TextInputType.number,
                          validator: (zipCode) {
                            if (zipCode!.isEmpty) {
                              return asProvider
                                  .getString('Enter your zip code');
                            }
                            if (zipCode.length <= 3) {
                              return asProvider
                                  .getString('Enter a valid zip code');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            saData.setZipCode(value);
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_addressFN);
                          },
                          // imagePath: 'assets/images/icons/mail.png',
                        ),
                        textFieldTitle(asProvider.getString('Address')),
                        // const SizedBox(height: 8),
                        CustomTextField(
                          asProvider.getString('Enter your address'),
                          focusNode: _addressFN,
                          validator: (address) {
                            if (address == null) {
                              return asProvider
                                  .getString('Enter your address.');
                            }
                            if (address.length <= 5) {
                              return asProvider
                                  .getString('Enter a valid address');
                            }
                            return null;
                          },
                          onChanged: (value) {
                            saData.setAddress(value);
                          },
                          onFieldSubmitted: (value) {
                            _onSubmit(context, saData);
                          },
                          // imagePath: 'assets/images/icons/mail.png',
                        ),
                      ]),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Stack(
                    children: [
                      customContainerButton(
                          saData.isLoading
                              ? ''
                              : asProvider.getString('Add Address'),
                          double.infinity,
                          saData.isLoading
                              ? () {}
                              : () {
                                  FocusScope.of(context).unfocus();
                                  _onSubmit(context, saData);
                                }),
                      if (saData.isLoading)
                        SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                                child: loadingProgressBar(
                                    size: 30, color: cc.pureWhite)))
                    ],
                  )),
              const SizedBox(height: 45)
            ],
          );
        }),
      ),
    );
  }
}
