import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/product/repository/product_repository.dart';

import 'cart_local_data_provider.dart';
import 'favorite_product_local_data_provider.dart';

final productRepositoryProvider = Provider.autoDispose<ProductRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );

    final favoriteProductLocalData = ref.read(
      favoriteProductLocalDataProvider,
    );

    final cartLocalData = ref.read(
      cartLocalDataProvider,
    );

    return ProductRepository(
      apiService: apiService,
      favoriteProductLocalData: favoriteProductLocalData,
      cartLocalData: cartLocalData,
    );
  },
);
