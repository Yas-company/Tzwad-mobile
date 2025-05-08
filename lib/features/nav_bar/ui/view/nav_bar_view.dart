import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({
    super.key,
    // required this.child,
  });

  // final Widget child;

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: Center(child: Text('NavBarView')),
    );
  }
}
