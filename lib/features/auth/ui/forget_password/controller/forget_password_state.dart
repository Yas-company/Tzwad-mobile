import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ForgetPasswordState {
  final DataState submitForgetPasswordDataState;
  final String phoneNumber;
  final String phoneNumberValidationMessage;
  final Failure? failure;

  ForgetPasswordState({
    this.submitForgetPasswordDataState = DataState.initial,
    this.phoneNumber = '',
    this.phoneNumberValidationMessage = '',
    this.failure,
  });

  ForgetPasswordState copyWith({
    DataState? submitForgetPasswordDataState,
    String? phoneNumber,
    String? phoneNumberValidationMessage,
    Failure? failure,
  }) {
    return ForgetPasswordState(
      submitForgetPasswordDataState: submitForgetPasswordDataState ?? this.submitForgetPasswordDataState,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberValidationMessage: phoneNumberValidationMessage ?? this.phoneNumberValidationMessage,
      failure: failure ?? this.failure,
    );
  }
}
