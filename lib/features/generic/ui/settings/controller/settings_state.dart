import 'package:tzwad_mobile/core/util/data_state.dart';

class SettingsState {
  final DataState submitLogoutDataState;
  final int index;
  final double page;

  SettingsState({
    this.submitLogoutDataState = DataState.loading,
    this.index = 0,
    this.page = 0.0,
  });

  SettingsState copyWith({
    DataState? submitLogoutDataState,
    int? index,
    double? page,
  }) {
    return SettingsState(
      submitLogoutDataState: submitLogoutDataState ?? this.submitLogoutDataState,
      index: index ?? this.index,
      page: page ?? this.page,
    );
  }
}
