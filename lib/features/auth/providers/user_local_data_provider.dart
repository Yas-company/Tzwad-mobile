import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/auth/local_data/user_local_data.dart';

final userLocalDataProvider = Provider.autoDispose<UserLocalData>(
  (ref) {
    return UserLocalData();
  },
);
