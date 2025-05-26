import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'change_password_state.dart';

class ChangePasswordController extends AutoDisposeNotifier<ChangePasswordState> {
  @override
  ChangePasswordState build() {
    state = _onInit();
    return state;
  }

  ChangePasswordState _onInit() => ChangePasswordState();

  void changeCurrentPassword(String currentPassword) {
    state = state.copyWith(
      currentPassword: currentPassword,
      currentPasswordValidationMessage: currentPassword.validatePassword,
    );
  }

  void changeVisibilityCurrentPassword() {
    state = state.copyWith(
      obscureTextCurrentPassword: !state.obscureTextCurrentPassword,
    );
  }

  void changeNewPassword(String newPassword) {
    state = state.copyWith(
      newPassword: newPassword,
      newPasswordValidationMessage: newPassword.validatePassword,
      reNewPasswordValidationMessage: state.reNewPassword.validateRePassword(newPassword),
    );
  }

  void changeVisibilityNewPassword() {
    state = state.copyWith(
      obscureTextNewPassword: !state.obscureTextNewPassword,
    );
  }

  void changeRePassword(String reNewPassword) {
    state = state.copyWith(
      reNewPassword: reNewPassword,
      reNewPasswordValidationMessage: reNewPassword.validateRePassword(state.newPassword),
    );
  }

  void changeVisibilityRePassword() {
    state = state.copyWith(
      obscureTextRePassword: !state.obscureTextRePassword,
    );
  }

  void changePassword() async {
    final repository = ref.read(authRepositoryProvider);
    final currentPasswordValidationMessage = state.currentPassword.validatePassword;
    final newPasswordValidationMessage = state.newPassword.validatePassword;
    final rePasswordValidationMessage = state.reNewPassword.validateRePassword(state.newPassword);
    if (currentPasswordValidationMessage.isNotEmpty || newPasswordValidationMessage.isNotEmpty || rePasswordValidationMessage.isNotEmpty) {
      state = state.copyWith(
        currentPasswordValidationMessage: currentPasswordValidationMessage,
        newPasswordValidationMessage: newPasswordValidationMessage,
        reNewPasswordValidationMessage: rePasswordValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitChangePasswordDataState: DataState.loading,
    );
    final result = await repository.changePassword(
      currentPassword: state.currentPassword,
      newPassword: state.newPassword,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitChangePasswordDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitChangePasswordDataState: DataState.success,
      ),
    );
  }
}
