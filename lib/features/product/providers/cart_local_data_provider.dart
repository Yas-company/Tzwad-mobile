import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/product/local_data/cart_local_data.dart';

final cartLocalDataProvider = Provider.autoDispose<CartLocalData>(
  (ref) {
    return CartLocalData();
  },
);
