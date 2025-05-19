import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/auth/providers/user_local_data_provider.dart';
import 'package:tzwad_mobile/features/auth/repository/auth_repository.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );

    final userLocalData = ref.read(
      userLocalDataProvider,
    );

    final settingLocalData = ref.read(
      settingLocalDataProvider,
    );

    return AuthRepository(
      apiService: apiService,
      userLocalData: userLocalData,
      settingLocalData: settingLocalData,
    );
  },
);
