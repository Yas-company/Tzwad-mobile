import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/favorite_products/controller/favorite_products_controller.dart';
import 'package:tzwad_mobile/features/product/ui/favorite_products/controller/favorite_products_state.dart';

final favoriteProductsControllerProvider = NotifierProvider.autoDispose<FavoriteProductsController, FavoriteProductsState>(
  () {
    return FavoriteProductsController();
  },
);
