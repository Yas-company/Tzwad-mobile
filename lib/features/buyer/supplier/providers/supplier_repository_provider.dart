import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/buyer/supplier/repository/supplier_repository.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';

final supplierRepositoryProvider = Provider.autoDispose<SupplierRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );


    final settingLocalData = ref.read(
      settingLocalDataProvider,
    );

    return SupplierRepository(
      apiService: apiService,
      settingLocalData: settingLocalData,
    );
  },
);
