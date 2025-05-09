import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/controller/product_details_controller.dart';
import 'package:tzwad_mobile/features/product/ui/product_details/controller/product_details_state.dart';

final productDetailsControllerProvider = NotifierProvider.autoDispose<ProductDetailsController, ProductDetailsState>(
  () {
    return ProductDetailsController();
  },
);
