import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/auth/repository/auth_repository.dart';

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) {
    return AuthRepository();
  },
);
