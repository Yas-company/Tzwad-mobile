import 'package:flutter/material.dart';
import 'package:gren_mart/view/utils/constant_name.dart';
import '../../service/auth_text_controller_service.dart';
import '../../view/auth/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../utils/constant_styles.dart';

class Login extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  Function onSave;
  String? initialPass;
  String? initialemail;
  Login(this._formKey, this.onSave,
      {this.initialemail, this.initialPass, Key? key})
      : super(key: key);
  final _passFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textFieldTitle(asProvider.getString('Username')),
        const SizedBox(height: 3),
        CustomTextField(
          'Email',
          leadingImage: 'assets/images/icons/mail.png',
          initialValue: initialemail,
          validator: (emailText) {
            if (emailText!.isEmpty) {
              return asProvider.getString('Enter your email/username');
            }
            Provider.of<AuthTextControllerService>(context, listen: false)
                .setEmail(emailText);
            return null;
          },
          onFieldSubmitted: (emailText) {
            Provider.of<AuthTextControllerService>(context, listen: false)
                .setEmail(emailText);
            FocusScope.of(context).requestFocus(_passFN);
          },
          onChanged: (emailText) {
            Provider.of<AuthTextControllerService>(context, listen: false)
                .setEmail(emailText);
          },
        ),
        textFieldTitle(asProvider.getString('Password')),
        CustomTextField(
          asProvider.getString('Password'),
          focusNode: _passFN,
          leadingImage: 'assets/images/icons/password.png',
          trailing: true,
          obscureText: true,
          initialValue: initialPass,
          validator: (pass) {
            if (pass == null || pass.length < 6) {
              return asProvider.getString('Password must be at least 6 digit.');
            }
            Provider.of<AuthTextControllerService>(context, listen: false)
                .setPass(pass);
            return null;
          },
          onChanged: (value) {
            Provider.of<AuthTextControllerService>(context, listen: false)
                .setPass(value);
          },
          onFieldSubmitted: (_) => onSave(),
        ),
      ]),
    );
  }
}
