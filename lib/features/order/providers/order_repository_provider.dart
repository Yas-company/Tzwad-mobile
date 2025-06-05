import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/order/repository/order_repository.dart';

final orderRepositoryProvider = Provider.autoDispose<OrderRepository>(
  (ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );
    return OrderRepository(
      apiService: apiService,
    );
  },
);
