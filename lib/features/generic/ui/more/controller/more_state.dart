import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class MoreState {
  final DataState submitLogoutDataState;
  final DataState submitDeleteAccountDataState;
  final int index;
  final double page;
  final Failure? failure;

  MoreState({
    this.submitLogoutDataState = DataState.initial,
    this.submitDeleteAccountDataState = DataState.initial,
    this.index = 0,
    this.page = 0.0,
    this.failure,
  });

  MoreState copyWith({DataState? submitLogoutDataState, DataState? submitDeleteAccountDataState, int? index, double? page, Failure? failure}) {
    return MoreState(
      submitLogoutDataState: submitLogoutDataState ?? this.submitLogoutDataState,
      submitDeleteAccountDataState: submitDeleteAccountDataState ?? this.submitDeleteAccountDataState,
      index: index ?? this.index,
      page: page ?? this.page,
      failure: failure ?? this.failure,
    );
  }
}
