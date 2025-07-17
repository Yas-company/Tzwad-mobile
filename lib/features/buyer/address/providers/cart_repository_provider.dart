import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/buyer/address/repository/address_repository.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';

final addressRepositoryProvider = Provider.autoDispose<AddressRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );

    final settingLocalData = ref.read(
      settingLocalDataProvider,
    );

    return AddressRepository(
      apiService: apiService,
      settingLocalData: settingLocalData,
    );
  },
);
