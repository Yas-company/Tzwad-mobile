import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/checkout_summary_info.dart';
import 'widgets/checkout_view_body.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => _onPressedBackButton(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('تنفيذ الطلب'),
      ),
      body: const CheckoutViewBody(),
      bottomNavigationBar: const CheckoutSummaryInfo(),
    );
  }

  _onPressedBackButton(BuildContext context) {
    Navigator.pop(context);
  }
}
