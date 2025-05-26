import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/change_password_view_body.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onPressedBackButton(context),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: const ChangePasswordViewBody(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    context.pop();
  }
}
