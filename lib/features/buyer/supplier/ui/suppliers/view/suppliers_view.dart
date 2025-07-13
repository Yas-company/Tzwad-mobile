import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/extension/widget_extension.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';

import 'widgets/suppliers_view_body.dart';
import 'widgets/switch_list_widget.dart';

class SuppliersView extends StatelessWidget {
  const SuppliersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => _onPressedBackButton(context),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('كل الموردين'),
          actions: [
            const SwitchListWidget().marginOnly(
              end: AppPadding.p16,
            ),
          ],
        ),
        body: const SuppliersViewBody());
  }

  _onPressedBackButton(BuildContext context) {
    Navigator.pop(context);
  }
}
