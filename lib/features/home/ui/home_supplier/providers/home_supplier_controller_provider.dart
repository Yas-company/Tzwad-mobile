import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/home/ui/home_supplier/controller/home_supplier_controller.dart';
import 'package:tzwad_mobile/features/home/ui/home_supplier/controller/home_supplier_state.dart';

final homeSupplierControllerProvider = NotifierProvider.autoDispose<HomeSupplierController, HomeSupplierState>(
  () {
    return HomeSupplierController();
  },
);
