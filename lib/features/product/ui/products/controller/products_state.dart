import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ProductsState {
  final DataState submitLoginDataState;
  final Failure? failure;

  ProductsState({
    this.submitLoginDataState = DataState.initial,
    this.failure,
  });

  ProductsState copyWith({
    DataState? submitLoginDataState,
    Failure? failure,
  }) {
    return ProductsState(
      submitLoginDataState: submitLoginDataState ?? this.submitLoginDataState,
      failure: failure ?? this.failure,
    );
  }
}
