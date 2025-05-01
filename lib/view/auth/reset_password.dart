import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../service/auth_text_controller_service.dart';
import '../../service/reset_pass_otp_service.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_colors.dart';
import 'package:provider/provider.dart';

import '../auth/custom_text_field.dart';
import '../utils/constant_styles.dart';

class ResetPassword extends StatefulWidget {
  static const routeName = 'reset password';
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  ConstantColors cc = ConstantColors();

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _newPasswordController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nPFN = FocusNode();
  final _reFN = FocusNode();

  @override
  Widget build(
    BuildContext context,
  ) {
    Future _onSubmit(BuildContext context) async {
      final valid = _formKey.currentState!.validate();
      if (!valid) {
        Provider.of<ResetPassOTPService>(context, listen: false)
            .togglePassLoadingSpinner(value: false);
        return;
      }
      await Provider.of<ResetPassOTPService>(context, listen: false)
          .resetPassword(
              Provider.of<AuthTextControllerService>(context, listen: false)
                  .newEmail,
              Provider.of<AuthTextControllerService>(context, listen: false)
                  .newPassword)
          .then((value) {
        if (value == null) {
          snackBar(context, asProvider.getString("Password reset succeeded"),
              backgroundColor: cc.primaryColor);
          Navigator.pop(context);
          return;
        }
        snackBar(context, value, backgroundColor: cc.orange);
        return;
      }).onError((error, stackTrace) {
        snackBar(context, error.toString(), backgroundColor: cc.orange);
        return;
      });
    }

    return Scaffold(
      appBar: AppBars()
          .appBarTitled(context, asProvider.getString('Reset Password'), () {
        Navigator.of(context).pop();
      }, hasButton: true),
      body: Consumer<ResetPassOTPService>(builder: (context, resetData, child) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textFieldTitle(asProvider.getString('New password')),
                      // const SizedBox(height: 8),
                      CustomTextField(
                        asProvider.getString('Enter new password'),
                        focusNode: _nPFN,
                        validator: (password) {
                          if (password!.isEmpty) {
                            return asProvider
                                .getString('Enter at least 6 characters');
                          }
                          if (password.length <= 5) {
                            return asProvider
                                .getString('Enter at least 6 characters');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          Provider.of<AuthTextControllerService>(context,
                                  listen: false)
                              .setNewPassword(value);
                        },
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_reFN);
                        },
                        trailing: true,
                        obscureText: true,
                      ),
                      textFieldTitle(
                          asProvider.getString('Re enter new password')),
                      // const SizedBox(height: 8),
                      CustomTextField(
                        asProvider.getString('Re enter new password'),
                        focusNode: _reFN,
                        validator: (password) {
                          if (password == _passwordController.text) {
                            return asProvider
                                .getString('Enter the same password');
                          }
                          return null;
                        },
                        onFieldSubmitted: (_) async {
                          Provider.of<ResetPassOTPService>(context,
                                  listen: false)
                              .togglePassLoadingSpinner(value: true);
                          await _onSubmit(context);
                          Provider.of<ResetPassOTPService>(context,
                                  listen: false)
                              .togglePassLoadingSpinner(value: false);
                        },
                        trailing: true,
                        obscureText: true,
                      ),
                    ]),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Stack(
                children: [
                  customContainerButton(
                      resetData.changePassLoading
                          ? ''
                          : asProvider.getString('Save Changes'),
                      double.infinity,
                      resetData.changePassLoading
                          ? () {}
                          : () async {
                              Provider.of<ResetPassOTPService>(context,
                                      listen: false)
                                  .togglePassLoadingSpinner(value: true);
                              await _onSubmit(context);
                              Provider.of<ResetPassOTPService>(context,
                                      listen: false)
                                  .togglePassLoadingSpinner(value: false);
                            }),
                  if (resetData.changePassLoading)
                    SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(
                            child: loadingProgressBar(
                                size: 30, color: cc.pureWhite)))
                ],
              ),
            ),
            const SizedBox(height: 45)
          ],
        );
      }),
    );
  }
}
