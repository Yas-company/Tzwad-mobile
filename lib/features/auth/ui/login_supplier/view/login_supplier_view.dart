import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_change_language_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/login_supplier_view_body.dart';

class LoginSupplierView extends StatelessWidget {
  const LoginSupplierView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onPressedBackButton(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          const AppButtonChangeLanguageWidget(),
        ],
      ),
      body: const LoginSupplierViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
