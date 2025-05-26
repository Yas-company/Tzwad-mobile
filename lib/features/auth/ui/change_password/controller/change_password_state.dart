import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class ChangePasswordState {
  final DataState submitChangePasswordDataState;
  final String currentPassword;
  final String currentPasswordValidationMessage;
  final bool obscureTextCurrentPassword;
  final String newPassword;
  final String newPasswordValidationMessage;
  final bool obscureTextNewPassword;
  final String reNewPassword;
  final String reNewPasswordValidationMessage;
  final bool obscureTextRePassword;
  final Failure? failure;

  ChangePasswordState({
    this.submitChangePasswordDataState = DataState.initial,
    this.currentPassword = '',
    this.currentPasswordValidationMessage = '',
    this.obscureTextCurrentPassword = true,
    this.newPassword = '',
    this.newPasswordValidationMessage = '',
    this.obscureTextNewPassword = true,
    this.reNewPassword = '',
    this.reNewPasswordValidationMessage = '',
    this.obscureTextRePassword = true,
    this.failure,
  });

  ChangePasswordState copyWith({
    DataState? submitChangePasswordDataState,
    String? currentPassword,
    String? currentPasswordValidationMessage,
    bool? obscureTextCurrentPassword,
    String? newPassword,
    String? newPasswordValidationMessage,
    bool? obscureTextNewPassword,
    String? reNewPassword,
    String? reNewPasswordValidationMessage,
    bool? obscureTextRePassword,
    Failure? failure,
  }) {
    return ChangePasswordState(
      submitChangePasswordDataState: submitChangePasswordDataState ?? this.submitChangePasswordDataState,
      currentPassword: currentPassword ?? this.currentPassword,
      currentPasswordValidationMessage: currentPasswordValidationMessage ?? this.currentPasswordValidationMessage,
      obscureTextCurrentPassword: obscureTextCurrentPassword ?? this.obscureTextCurrentPassword,
      newPassword: newPassword ?? this.newPassword,
      newPasswordValidationMessage: newPasswordValidationMessage ?? this.newPasswordValidationMessage,
      obscureTextNewPassword: obscureTextNewPassword ?? this.obscureTextNewPassword,
      reNewPassword: reNewPassword ?? this.reNewPassword,
      reNewPasswordValidationMessage: reNewPasswordValidationMessage ?? this.reNewPasswordValidationMessage,
      obscureTextRePassword: obscureTextRePassword ?? this.obscureTextRePassword,
      failure: failure ?? this.failure,
    );
  }
}
