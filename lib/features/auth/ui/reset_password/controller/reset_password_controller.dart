import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'reset_password_state.dart';

class ResetPasswordController extends AutoDisposeNotifier<ResetPasswordState> {
  @override
  ResetPasswordState build() {
    state = _onInit();
    return state;
  }

  ResetPasswordState _onInit() => ResetPasswordState();

  void changePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordValidationMessage: password.validatePassword,
      rePasswordValidationMessage: state.rePassword.validateRePassword(password),
    );
  }

  void changeVisibilityPassword() {
    state = state.copyWith(
      obscureTextPassword: !state.obscureTextPassword,
    );
  }

  void changeRePassword(String rePassword) {
    state = state.copyWith(
      rePassword: rePassword,
      rePasswordValidationMessage: rePassword.validateRePassword(state.password),
    );
  }

  void changeVisibilityRePassword() {
    state = state.copyWith(
      obscureTextRePassword: !state.obscureTextRePassword,
    );
  }

  void resetPassword(String phoneNumber) async {
    final repository = ref.read(authRepositoryProvider);
    final passwordValidationMessage = state.password.validatePassword;
    final rePasswordValidationMessage = state.rePassword.validateRePassword(state.password);
    if (passwordValidationMessage.isNotEmpty || rePasswordValidationMessage.isNotEmpty) {
      state = state.copyWith(
        passwordValidationMessage: passwordValidationMessage,
        rePasswordValidationMessage: rePasswordValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitResetPasswordDataState: DataState.loading,
    );
    final result = await repository.resetPassword(
      phoneNumber: phoneNumber,
      newPassword: state.password,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitResetPasswordDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitResetPasswordDataState: DataState.success,
      ),
    );
  }
}
