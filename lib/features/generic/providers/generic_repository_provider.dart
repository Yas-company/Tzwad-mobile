import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/generic/repository/generic_repository.dart';

final genericRepositoryProvider = Provider.autoDispose<GenericRepository>(
  (ref) {
    return GenericRepository();
  },
);
