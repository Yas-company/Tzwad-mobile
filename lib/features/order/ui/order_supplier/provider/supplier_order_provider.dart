import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_controller.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_details_controller.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_details_state.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_state.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/repository/order_supplier_repository.dart';


final supplierOrderProvider = NotifierProvider.autoDispose<SupplierOrderController,
    SupplierOrderState>(() {
    return SupplierOrderController();
  },
);


final supplierOrderRepositoryProvider = Provider.autoDispose<OrderSupplierRepository>((ref) {
  final apiService = ref.read(
    apiServiceProvider,);
  return OrderSupplierRepository(apiService: apiService,);
},
);


final supplierOrderDetailsControllerProvider = NotifierProvider.autoDispose<SupplierOrderDetailsController,
    SupplierOrderDetailsState>(() {
    return SupplierOrderDetailsController();
  },
);




