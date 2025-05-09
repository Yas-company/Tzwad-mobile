import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_details_state.dart';

class ProductDetailsController extends AutoDisposeNotifier<ProductDetailsState> {
  @override
  ProductDetailsState build() {
    state = _onInit();
    return state;
  }

  ProductDetailsState _onInit() => ProductDetailsState();
}
