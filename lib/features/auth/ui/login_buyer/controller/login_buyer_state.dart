import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class LoginBuyerState {
  final DataState submitLoginDataState;
  final String phoneNumber;
  final String phoneNumberValidationMessage;
  final String password;
  final String passwordValidationMessage;
  final bool obscureText;
  final bool isRememberMe;
  final Failure? failure;

  LoginBuyerState({
    this.submitLoginDataState = DataState.initial,
    this.phoneNumber = '',
    this.phoneNumberValidationMessage = '',
    this.password = '',
    this.passwordValidationMessage = '',
    this.obscureText = true,
    this.isRememberMe = true,
    this.failure,
  });

  LoginBuyerState copyWith({
    DataState? submitLoginDataState,
    String? phoneNumber,
    String? phoneNumberValidationMessage,
    String? password,
    String? passwordValidationMessage,
    bool? obscureText,
    bool? isRememberMe,
    Failure? failure,
  }) {
    return LoginBuyerState(
      submitLoginDataState: submitLoginDataState ?? this.submitLoginDataState,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberValidationMessage: phoneNumberValidationMessage ?? this.phoneNumberValidationMessage,
      password: password ?? this.password,
      passwordValidationMessage: passwordValidationMessage ?? this.passwordValidationMessage,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      obscureText: obscureText ?? this.obscureText,
      failure: failure ?? this.failure,
    );
  }
}
