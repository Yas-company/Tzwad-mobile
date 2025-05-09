import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'products_state.dart';

class ProductsController extends AutoDisposeNotifier<ProductsState> {
  @override
  ProductsState build() {
    state = _onInit();
    return state;
  }

  ProductsState _onInit() => ProductsState();
}
