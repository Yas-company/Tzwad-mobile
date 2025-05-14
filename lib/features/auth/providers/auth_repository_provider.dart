import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/core/local_data/app_preferences_provider.dart';
import 'package:tzwad_mobile/features/auth/repository/auth_repository.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );

    final appPrefs = ref.read(
      appPreferencesProvider,
    );

    return AuthRepository(
      apiService: apiService,
      appPrefs: appPrefs,
    );
  },
);
