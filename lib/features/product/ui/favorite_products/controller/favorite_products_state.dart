import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class FavoriteProductsState {
  final DataState submitLoginDataState;
  final Failure? failure;

  FavoriteProductsState({
    this.submitLoginDataState = DataState.initial,
    this.failure,
  });

  FavoriteProductsState copyWith({
    DataState? submitLoginDataState,
    Failure? failure,
  }) {
    return FavoriteProductsState(
      submitLoginDataState: submitLoginDataState ?? this.submitLoginDataState,
      failure: failure ?? this.failure,
    );
  }
}
