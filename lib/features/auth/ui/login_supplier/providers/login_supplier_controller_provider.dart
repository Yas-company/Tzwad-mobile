import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/controller/login_supplier_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/controller/login_supplier_state.dart';

final loginSupplierControllerProvider = NotifierProvider.autoDispose<LoginSupplierController, LoginSupplierState>(
  () {
    return LoginSupplierController();
  },
);
