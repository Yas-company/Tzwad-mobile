import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/state_dropdown.dart';
import 'package:gren_mart/view/utils/web_view.dart';
import '../../service/auth_text_controller_service.dart';
import '../../service/common_service.dart';
import '../../service/country_dropdown_service.dart';
import '../../service/signin_signup_service.dart';
import '../../view/utils/constant_name.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

import '../../service/state_dropdown_service.dart';
import '../utils/constant_styles.dart';
import '../utils/country_dropdown.dart';
import 'custom_text_field.dart';

class SignUp extends StatelessWidget {
  final Key _formkey;

  SignUp(
    this._formkey, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthTextControllerService>(
        builder: (context, authController, child) {
      return Form(
        key: _formkey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textFieldTitle(asProvider.getString('Name')),
          // const SizedBox(height: 8),
          CustomTextField(
            asProvider.getString('Enter name'),
            validator: (nameText) {
              if (nameText!.isEmpty) {
                return asProvider.getString('Enter your name');
              }
              if (nameText.length <= 2) {
                return asProvider.getString('Enter a valid name');
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (name) {
              authController.setName(name);
            },
          ),
          textFieldTitle(asProvider.getString('User name')),
          // const SizedBox(height: 8),
          CustomTextField(
            asProvider.getString('Enter user name'),
            validator: (ussernameText) {
              if (ussernameText!.isEmpty) {
                return asProvider.getString('Enter your username');
              }
              if (ussernameText.trim().contains(' ')) {
                return asProvider.getString('Enter username without space');
              }
              return null;
            },
            onChanged: (username) {
              authController.setNewUsername(username);
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
          ),
          textFieldTitle(asProvider.getString('Email')),
          // const SizedBox(height: 8),
          CustomTextField(
            asProvider.getString('Enter email address'),
            validator: (emaiText) {
              if (emaiText!.isEmpty) {
                return asProvider.getString('Enter your email');
              }
              print(EmailValidator.validate(emaiText.trim()));
              if (!EmailValidator.validate(emaiText.trim())) {
                return asProvider.getString('Enter a valid email');
              }
              return null;
            },
            onChanged: (email) {
              authController.setNewEmail(email);
            },
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
              authController.setPhoneNumber(value);
            },
          ),
          textFieldTitle(asProvider.getString('Country')),
          // const SizedBox(height: 8),
          Consumer<CountryDropdownService>(
            builder: (context, cProvider, child) => CountryDropdown(
              hintText: "Select Country",
              textStyle: TextStyle(color: cc.greyHint),
              iconColor: cc.greyHint,
              selectedValue: cProvider.selectedCountry,
              onChanged: (newValue) {
                cProvider.setCountryIdAndValue(newValue, context);
                authController.setCountry(cProvider.selectedCountryId);
                authController.setState(null);
              },
              textFieldHint: "Search Country",
            ),
          ),
          Consumer<CountryDropdownService>(
              builder: (context, cProvider, child) =>
                  cProvider.selectedCountry != null
                      ? textFieldTitle(asProvider.getString('State'))
                      : SizedBox()),
          Consumer<CountryDropdownService>(
              builder: (context, cProvider, child) => cProvider
                          .selectedCountry !=
                      null
                  ? Consumer<StateDropdownService>(
                      builder: ((context, sProvider, child) => StateDropdown(
                            hintText: "Select State",
                            textStyle: TextStyle(color: cc.greyHint),
                            iconColor: cc.greyHint,
                            selectedValue: sProvider.selectedState,
                            onChanged: (newValue) {
                              sProvider.setStateIdAndValue(newValue);
                              authController.setState(sProvider.selectedState);
                            },
                            textFieldHint: "Search State",
                          )))
                  : SizedBox()),
          // textFieldTitle('City'),
          // // const SizedBox(height: 8),
          // CustomTextField(
          //   'City',
          //   validator: (cityText) {
          //     if (cityText!.isEmpty) {
          //       return 'Enter a valid city name';
          //     }
          //     if (cityText.length <= 2) {
          //       return 'Enter a valid city name';
          //     }
          //     return null;
          //   },
          //   onFieldSubmitted: (_) {
          //     FocusScope.of(context).unfocus();
          //   },
          //   onChanged: (city) {
          //     authController.setCityAddress(city);
          //   },
          // ),
          textFieldTitle(asProvider.getString('Password')),
          CustomTextField(
            asProvider.getString('Enter password'),
            trailing: true,
            obscureText: true,
            validator: (password) {
              if (password!.isEmpty) {
                return asProvider.getString('Enter at least 6 characters');
              }
              if (password.length <= 5) {
                return asProvider.getString('Enter at least 6 characters');
              }
              if (password.trim().contains(' ')) {
                return asProvider.getString('Enter password without any space');
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (pass) {
              authController.setNewPassword(pass);
            },
          ),
          textFieldTitle(asProvider.getString('Confirm Password')),
          // const SizedBox(height: 8),
          CustomTextField(
            asProvider.getString('Re enter password'),
            trailing: true,
            obscureText: true,
            validator: (password) {
              if (password != authController.newPassword) {
                return asProvider.getString('Enter the same password');
              }
              return null;
            },
            onFieldSubmitted: (_) {},
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Transform.scale(
                scale: 1.3,
                child: Checkbox(

                    // splashRadius: 30,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(
                      width: 1,
                      color: cc.greyBorder,
                    ),
                    activeColor: cc.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: BorderSide(
                          width: 1,
                          color: cc.greyBorder,
                        )),
                    value:
                        Provider.of<SignInSignUpService>(context).termsAndCondi,
                    onChanged: (value) {
                      FocusScope.of(context).unfocus();
                      Provider.of<SignInSignUpService>(context, listen: false)
                          .toggleTermsAndCondi();
                    }),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: screenWidth - 85,
                child: FittedBox(
                  child: RichText(
                    softWrap: true,
                    text: TextSpan(
                        text: asProvider.getString('Accept all') + ' ',
                        style: TextStyle(
                          color: cc.greyHint,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pushNamed(
                                        WebViewScreen.routeName,
                                        arguments: [
                                          asProvider.getString(
                                              'Terms and Conditions'),
                                          '$baseApiUrl/terms-and-condition-page'
                                        ]),
                              text: '' +
                                  asProvider.getString('Terms and Conditions'),
                              style: TextStyle(color: cc.primaryColor)),
                          TextSpan(
                              text: ' & ',
                              style: TextStyle(color: cc.greyHint)),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pushNamed(
                                        WebViewScreen.routeName,
                                        arguments: [
                                          asProvider
                                              .getString('Privacy Policy'),
                                          '$baseApiUrl/privacy-policy-page'
                                        ]),
                              text: asProvider.getString('Privacy Policy'),
                              style: TextStyle(color: cc.primaryColor)),
                        ]),
                  ),
                ),
              ),
            ],
          )
        ]),
      );
    });
  }
}
