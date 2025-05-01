import 'package:flutter/material.dart';
import 'package:gren_mart/service/user_profile_service.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../service/change_password_service.dart';
import '../../service/signin_signup_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

import '../auth/custom_text_field.dart';
import '../utils/constant_styles.dart';

class ChangePassword extends StatefulWidget {
  static const routeName = 'change password';
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ConstantColors cc = ConstantColors();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nPFN = FocusNode();
  final _reFN = FocusNode();

  Future _onSubmit(BuildContext context, ChangePasswordService cpData) async {
    final uProvider = Provider.of<UserProfileService>(context, listen: false);
    if (uProvider.userProfileData?.googleId != null ||
        uProvider.userProfileData?.facebookId != null) {
      return;
    }
    final valide = _formKey.currentState!.validate();
    if (!valide) {
      return;
    }
    cpData.toggPassleLaodingSpinner(value: true);
    cpData
        .changePassword(cpData.currentPass, cpData.newPass,
            Provider.of<SignInSignUpService>(context, listen: false).token)
        .then((value) {
      if (value != null) {
        print(value);
        snackBar(context, value ?? '');
        cpData.toggPassleLaodingSpinner(value: false);
        return;
      }
      snackBar(context, asProvider.getString("Password changed successfully"),
          backgroundColor: cc.primaryColor);
      cpData.toggPassleLaodingSpinner(value: false);
      Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      cpData.toggPassleLaodingSpinner(value: false);
      snackBar(context, '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars()
          .appBarTitled(context, asProvider.getString('Change Password'), () {
        Navigator.of(context).pop();
      }, hasButton: true),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Consumer<ChangePasswordService>(
                  builder: (context, cpData, child) {
                return Column(
                  children: [
                    const SizedBox(height: 10),
                    Consumer<UserProfileService>(
                        builder: (context, uService, child) {
                      return uService.userProfileData?.googleId != null ||
                              uService.userProfileData?.facebookId != null
                          ? Padding(
                              padding: EdgeInsets.all(30),
                              child: Text(
                                  asProvider.getString(
                                      "Password Change Unavailable. We're sorry, but users who have signed up or logged in using their Google or Facebook accounts do not have the option to change their password directly on this platform. "),
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: cc.orange,
                                  )))
                          : SizedBox();
                    }),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textFieldTitle(
                                    asProvider.getString('Current password')),
                                // const SizedBox(height: 8),
                                CustomTextField(
                                  asProvider
                                      .getString('Enter current password'),
                                  validator: (cPass) {
                                    if (cPass!.isEmpty) {
                                      return asProvider.getString(
                                          'Enter at least 6 characters');
                                    }
                                    if (cPass.length <= 5) {
                                      return asProvider.getString(
                                          'Enter at least 6 characters');
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    cpData.setCurrentPass(value);
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_nPFN);
                                  },
                                  trailing: true,
                                  obscureText: true,
                                ),
                                textFieldTitle(
                                    asProvider.getString('New password')),
                                // const SizedBox(height: 8),
                                CustomTextField(
                                  asProvider.getString('Enter new password'),
                                  focusNode: _nPFN,
                                  validator: (nPass) {
                                    if (nPass!.isEmpty) {
                                      return asProvider.getString(
                                          'Enter at least 6 characters');
                                    }
                                    if (nPass.length <= 5) {
                                      return asProvider.getString(
                                          'Enter at least 6 characters');
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    cpData.setNewPass(value);
                                  },
                                  onFieldSubmitted: (_) {
                                    FocusScope.of(context).requestFocus(_reFN);
                                  },
                                  trailing: true,
                                  obscureText: true,
                                ),
                                textFieldTitle(asProvider
                                    .getString('Re enter new password')),
                                // const SizedBox(height: 8),
                                CustomTextField(
                                  asProvider.getString('Re enter new password'),
                                  focusNode: _reFN,
                                  validator: (nPass) {
                                    if (nPass != cpData.newPass) {
                                      return asProvider
                                          .getString('Enter the same password');
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (_) {
                                    _onSubmit(context, cpData);
                                  },
                                  trailing: true,
                                  obscureText: true,
                                ),
                              ]),
                        )),
                    const Spacer(),
                    Consumer<UserProfileService>(
                        builder: (context, uService, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Stack(
                          children: [
                            customContainerButton(
                                cpData.changePassLoading
                                    ? ''
                                    : asProvider.getString('Save Changes'),
                                double.infinity,
                                cpData.changePassLoading ||
                                        (uService.userProfileData?.googleId !=
                                                null ||
                                            uService.userProfileData
                                                    ?.facebookId !=
                                                null)
                                    ? () {}
                                    : () async {
                                        await _onSubmit(context, cpData);
                                      },
                                color: uService.userProfileData?.googleId !=
                                            null ||
                                        uService.userProfileData?.facebookId !=
                                            null
                                    ? cc.greyHint
                                    : null),
                            if (cpData.changePassLoading)
                              SizedBox(
                                  height: 50,
                                  width: double.infinity,
                                  child: Center(
                                      child: loadingProgressBar(
                                          size: 30, color: cc.pureWhite)))
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 45)
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }
}
