import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/category/repository/category_repository.dart';

final categoryRepositoryProvider = Provider.autoDispose<CategoryRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );

    return CategoryRepository(
      apiService: apiService,
    );
  },
);
