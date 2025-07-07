import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

class SuppliersView extends StatelessWidget {
  const SuppliersView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: const Text('Suppliers'),
      ),
      body: const Center(
        child: Text('Suppliers View'),
      ),
    );
  }
}
