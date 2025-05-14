import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences_provider.dart';
import 'package:tzwad_mobile/features/product/repository/product_repository.dart';

final productRepositoryProvider = Provider.autoDispose<ProductRepository>(
  (ref) {
    final appPrefs = ref.read(appPreferencesProvider);
    return ProductRepository(appPrefs);
  },
);
