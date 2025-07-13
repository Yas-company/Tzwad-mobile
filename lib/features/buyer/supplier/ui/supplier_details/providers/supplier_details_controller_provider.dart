import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/controller/supplier_details_controller.dart';
import 'package:tzwad_mobile/features/buyer/supplier/ui/supplier_details/controller/supplier_details_state.dart';

final supplierDetailsControllerProvider = NotifierProvider.autoDispose<SupplierDetailsController, SupplierDetailsState>(
  () {
    return SupplierDetailsController();
  },
);
