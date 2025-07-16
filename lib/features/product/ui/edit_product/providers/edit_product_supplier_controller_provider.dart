import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/edit_product_supplier_controller.dart';
import '../controller/edit_product_supplier_state.dart';

final EditProductControllerProvider =
StateNotifierProvider<EditProductController, EditProductState>(
      (ref) => EditProductController(ref),
);