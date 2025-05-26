import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/controller/settings_controller.dart';
import 'package:tzwad_mobile/features/generic/ui/settings/controller/settings_state.dart';

final settingsControllerProvider = NotifierProvider.autoDispose<SettingsController, SettingsState>(
  () {
    return SettingsController();
  },
);
