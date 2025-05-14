import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences_provider.dart';
import 'package:tzwad_mobile/features/category/repository/category_repository.dart';

final categoryRepositoryProvider = Provider.autoDispose<CategoryRepository>(
  (ref) {
    final appPrefs = ref.read(appPreferencesProvider);
    return CategoryRepository(appPrefs);
  },
);
