import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/products/controller/products_controller.dart';
import 'package:tzwad_mobile/features/product/ui/products/controller/products_state.dart';

final productsControllerProvider = NotifierProvider.autoDispose<ProductsController, ProductsState>(
  () {
    return ProductsController();
  },
);
