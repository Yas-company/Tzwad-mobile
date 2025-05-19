import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/generic/local_data/setting_local_data.dart';

final settingLocalDataProvider = Provider.autoDispose<SettingLocalData>(
  (ref) {
    return SettingLocalData();
  },
);
