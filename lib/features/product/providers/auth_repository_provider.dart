import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/product/repository/product_repository.dart';

final productRepositoryProvider = Provider.autoDispose<ProductRepository>(
  (ref) {
    return ProductRepository();
  },
);
