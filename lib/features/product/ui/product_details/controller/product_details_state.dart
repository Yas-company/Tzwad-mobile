import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ProductDetailsState {
  final DataState submitLoginDataState;
  final Failure? failure;

  ProductDetailsState({
    this.submitLoginDataState = DataState.initial,
    this.failure,
  });

  ProductDetailsState copyWith({
    DataState? submitLoginDataState,
    Failure? failure,
  }) {
    return ProductDetailsState(
      submitLoginDataState: submitLoginDataState ?? this.submitLoginDataState,
      failure: failure ?? this.failure,
    );
  }
}
