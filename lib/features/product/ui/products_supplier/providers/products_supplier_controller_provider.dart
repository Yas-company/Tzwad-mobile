import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controller/products_supplier_controller.dart';
import '../controller/products_supplier_state.dart';

final productsSupplierControllerProvider = NotifierProvider.autoDispose<ProductsSupplierController, ProductsSupplierState>(
      () {
    return ProductsSupplierController();
  },
);

final isSearchVisibleProvider = StateProvider.autoDispose<bool>((ref) => false);


final supplierSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
