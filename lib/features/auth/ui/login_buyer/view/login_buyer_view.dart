import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_change_language_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/login_as_supplier_widget.dart';
import 'widgets/login_buyer_view_body.dart';

class LoginBuyerView extends StatelessWidget {
  const LoginBuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        actions: [
          const AppButtonChangeLanguageWidget(),
        ],
      ),
      body: const LoginBuyerViewBody(),
      bottomNavigationBar: const LoginAsSupplierWidget(),
    );
  }


}
