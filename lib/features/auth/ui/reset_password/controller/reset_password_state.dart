import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ResetPasswordState {
  final DataState submitResetPasswordDataState;
  final String password;
  final String passwordValidationMessage;
  final bool obscureTextPassword;
  final String rePassword;
  final String rePasswordValidationMessage;
  final bool obscureTextRePassword;
  final Failure? failure;

  ResetPasswordState({
    this.submitResetPasswordDataState = DataState.initial,
    this.password = '',
    this.passwordValidationMessage = '',
    this.obscureTextPassword = true,
    this.rePassword = '',
    this.rePasswordValidationMessage = '',
    this.obscureTextRePassword = true,
    this.failure,
  });

  ResetPasswordState copyWith({
    DataState? submitResetPasswordDataState,
    String? password,
    String? passwordValidationMessage,
    bool? obscureTextPassword,
    String? rePassword,
    String? rePasswordValidationMessage,
    bool? obscureTextRePassword,
    Failure? failure,
  }) {
    return ResetPasswordState(
      submitResetPasswordDataState: submitResetPasswordDataState ?? this.submitResetPasswordDataState,
      password: password ?? this.password,
      passwordValidationMessage: passwordValidationMessage ?? this.passwordValidationMessage,
      obscureTextPassword: obscureTextPassword ?? this.obscureTextPassword,
      rePassword: rePassword ?? this.rePassword,
      rePasswordValidationMessage: rePasswordValidationMessage ?? this.rePasswordValidationMessage,
      obscureTextRePassword: obscureTextRePassword ?? this.obscureTextRePassword,
      failure: failure ?? this.failure,
    );
  }
}
