
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/add_product_supplier_controller.dart';
import '../controller/add_product_supplier_state.dart';

final addProductControllerProvider =
StateNotifierProvider<AddProductController, AddProductState>(
      (ref) => AddProductController(ref),
);