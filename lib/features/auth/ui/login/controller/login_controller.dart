import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/services/app_prefs/app_preferences_provider.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'login_state.dart';

class LoginController extends AutoDisposeNotifier<LoginState> {
  @override
  LoginState build() {
    state = _onInit();
    return state;
  }

  LoginState _onInit() => LoginState();

  void changePhoneNumber(String phoneNumber) {
    state = state.copyWith(
      phoneNumber: phoneNumber,
      phoneNumberValidationMessage: phoneNumber.validatePhoneNumber,
    );
  }

  void changePassword(String password) {
    state = state.copyWith(
      password: password,
      passwordValidationMessage: password.validatePassword,
    );
  }

  void changeVisibilityPassword() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  void changeRememberMe() {
    state = state.copyWith(
      isRememberMe: !state.isRememberMe,
    );
  }

  void login() async {
    final repository = ref.read(authRepositoryProvider);
    final appPrefs = ref.read(appPreferencesProvider);
    state = state.copyWith(
      isLoading: true,
    );
    final result = await repository.login(
      phoneNumber: state.phoneNumber,
      password: state.password,
    );
    result.fold(
      (l) => state = state.copyWith(
        isLoading: false,
      ),
      (r) => state = state.copyWith(
        isLoading: false,
      ),
    );
  }
}
