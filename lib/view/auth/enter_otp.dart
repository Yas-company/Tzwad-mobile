import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../service/auth_text_controller_service.dart';
import '../../service/reset_pass_otp_service.dart';
import '../../view/auth/reset_password.dart';
import '../../view/utils/app_bars.dart';
import '../../view/utils/constant_name.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../utils/constant_colors.dart';
import '../utils/constant_styles.dart';
import '../utils/text_themes.dart';

class EnterOTP extends StatelessWidget {
  static const routeName = 'confirm OTP';
  EnterOTP({Key? key}) : super(key: key);

  ConstantColors cc = ConstantColors();
  TextEditingController controller = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    initiateDeviceSize(context);
    final defaultPinTheme = PinTheme(
      width: 85,
      height: 56,
      textStyle: TextStyle(
        fontSize: 17,
        color: cc.greyParagraph,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: cc.greyBorder),
        borderRadius: BorderRadius.circular(10),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: cc.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBars().appBarTitled(context, '', () {
        Navigator.of(context).pop();
      }, hasElevation: false),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(height: screenHight / 20),
                Center(
                  child: SizedBox(
                    height: 90,
                    child: Image.asset('assets/images/email.png'),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  asProvider.getString('Reset Password'),
                  style: TextThemeConstrants.titleText,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    asProvider.getString(
                        'Enter the 4 digit code we sent to to your email in order to reset password'),
                    textAlign: TextAlign.center,
                    style: TextThemeConstrants.paragraphText,
                  ),
                ),
                const SizedBox(height: 20),
                otpPinput(defaultPinTheme, focusedPinTheme, context),
                const SizedBox(height: 35),
                Consumer<ResetPassOTPService>(
                    builder: (context, rpoService, child) {
                  return Center(
                    child: RichText(
                      text: TextSpan(
                        text: asProvider.getString("Didn't received?"),
                        style: TextThemeConstrants.paragraphText,
                        children: <TextSpan>[
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  rpoService.toggleLoadingSpinner(value: true);
                                  await rpoService
                                      .getOtp(Provider.of<
                                                  AuthTextControllerService>(
                                              context,
                                              listen: false)
                                          .newEmail)
                                      .onError((error, stackTrace) => rpoService
                                          .toggleLoadingSpinner(value: false));
                                  rpoService.toggleLoadingSpinner(value: false);
                                },
                              text: asProvider.getString('Send again'),
                              style: TextStyle(
                                  color: cc.primaryColor,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  );
                })
              ]),
            ),
          ),
          Consumer<ResetPassOTPService>(
            builder: (context, rpoService, child) {
              return rpoService.isLoading
                  ? Container(
                      color: Colors.white60,
                      child: loadingProgressBar(),
                    )
                  : SizedBox();
            },
          )
        ],
      ),
    );
  }

  Pinput otpPinput(PinTheme defaultPinTheme, PinTheme focusedPinTheme,
      BuildContext context) {
    return Pinput(
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      validator: (s) {
        if (s ==
            Provider.of<ResetPassOTPService>(context, listen: false)
                .getOtpModel
                .otp) {
          Navigator.of(context).pushReplacementNamed(ResetPassword.routeName);
          return;
        }
        controller.clear();

        // _scaffoldKey.currentState!.showSnackBar(snackBar);

        snackBar(context, asProvider.getString('Wrong OTP Code'),
            buttonText: asProvider.getString('Resend code'), onTap: () {
          Provider.of<ResetPassOTPService>(context, listen: false)
              .toggleLoadingSpinner(value: true);
          Provider.of<ResetPassOTPService>(context, listen: false)
              .getOtp(
                  Provider.of<AuthTextControllerService>(context, listen: false)
                      .newEmail)
              .then((value) =>
                  Provider.of<ResetPassOTPService>(context, listen: false)
                      .toggleLoadingSpinner(value: false))
              .onError((error, stackTrace) =>
                  Provider.of<ResetPassOTPService>(context, listen: false)
                      .toggleLoadingSpinner(value: false));
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }, backgroundColor: cc.orange);

        return;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
