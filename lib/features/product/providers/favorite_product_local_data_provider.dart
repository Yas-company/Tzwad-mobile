import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/product/local_data/favorite_product_local_data.dart';

final favoriteProductLocalDataProvider = Provider.autoDispose<FavoriteProductLocalData>(
  (ref) {
    return FavoriteProductLocalData();
  },
);
