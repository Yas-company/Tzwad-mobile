import 'package:flutter/material.dart';
import 'package:tzwad_mobile/features/auth/models/role_enum.dart';

class AppPermissionRoleWidget extends StatelessWidget {
  const AppPermissionRoleWidget({
    super.key,
    required this.role,
    required this.buyerWidget,
    required this.supplierWidget,
  });

  final RoleEnum role;
  final Widget buyerWidget;
  final Widget supplierWidget;

  @override
  Widget build(BuildContext context) {
    switch (role) {
      case RoleEnum.buyer:
        return buyerWidget;
      case RoleEnum.supplier:
        return supplierWidget;
      }
  }
}
