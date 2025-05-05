import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';

import 'widgets/undefined_route_view_body.dart';

class UnDefinedRouteView extends StatelessWidget {
  const UnDefinedRouteView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        title: Text(
          'AppStrings.strNoRouteFound.tr(context)',
        ),
      ),
      body: UnDefinedRouteViewBody(),
    );
  }
}
