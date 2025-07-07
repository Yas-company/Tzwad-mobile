import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_permission_role_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';

import 'widgets/buyer_bottom_navigation.dart';
import 'widgets/supplier_bottom_navigation.dart';

class NavBarView extends StatelessWidget {
  const NavBarView({
    super.key,
    required this.child,
    required this.role,
  });

  final Widget child;
  final RoleEnum role;

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      userSafeArea: false,
      body: child,
      bottomNavigationBar: AppPermissionRoleWidget(
        role: role,
        buyerWidget: const BuyerBottomNavigation(),
        supplierWidget: const SupplierBottomNavigation(),
      ),
    );
  }
}
