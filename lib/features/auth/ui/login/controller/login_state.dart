import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class LoginState {
  final DataState submitLoginDataState;
  final String phoneNumber;
  final String phoneNumberValidationMessage;
  final String password;
  final String passwordValidationMessage;
  final bool obscureText;
  final bool isRememberMe;
  final Failure? failure;

  LoginState({
    this.submitLoginDataState = DataState.initial,
    this.phoneNumber = '',
    this.phoneNumberValidationMessage = '',
    this.password = '',
    this.passwordValidationMessage = '',
    this.obscureText = true,
    this.isRememberMe = false,
    this.failure,
  });

  LoginState copyWith({
    DataState? submitLoginDataState,
    String? phoneNumber,
    String? phoneNumberValidationMessage,
    String? password,
    String? passwordValidationMessage,
    bool? obscureText,
    bool? isRememberMe,
    Failure? failure,
  }) {
    return LoginState(
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
