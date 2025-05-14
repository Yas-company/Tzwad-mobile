import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/custom_bottom_navigation.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: child,
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
