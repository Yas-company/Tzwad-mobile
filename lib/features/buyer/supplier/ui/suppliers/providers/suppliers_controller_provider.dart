import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/suppliers/controller/suppliers_controller.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/suppliers/controller/suppliers_state.dart';

final suppliersControllerProvider = NotifierProvider.autoDispose<SuppliersController, SuppliersState>(
  () {
    return SuppliersController();
  },
);
