import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';

import 'api_service.dart';

final apiServiceProvider = Provider.autoDispose<ApiService>(
  (ref) {
    final settingLocalData = ref.read(settingLocalDataProvider);
    return ApiService(
      settingLocalData: settingLocalData,
    );
  },
);
