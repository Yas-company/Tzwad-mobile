import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences_provider.dart';

import 'api_service.dart';

final apiServiceProvider = Provider.autoDispose<ApiService>(
  (ref) {
    final appPrefs = ref.read(appPreferencesProvider);
    return ApiService(appPrefs);
  },
);
