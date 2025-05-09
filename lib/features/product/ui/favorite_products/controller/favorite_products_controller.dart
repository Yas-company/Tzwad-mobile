import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'favorite_products_state.dart';

class FavoriteProductsController extends AutoDisposeNotifier<FavoriteProductsState> {
  @override
  FavoriteProductsState build() {
    state = _onInit();
    return state;
  }

  FavoriteProductsState _onInit() => FavoriteProductsState();
}
