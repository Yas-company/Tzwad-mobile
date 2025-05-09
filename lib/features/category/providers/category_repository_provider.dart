import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/category/repository/category_repository.dart';

final categoryRepositoryProvider = Provider.autoDispose<CategoryRepository>(
  (ref) {
    return CategoryRepository();
  },
);
