class LoginState {
  final bool isLoading;
  final String phoneNumber;
  final String? phoneNumberValidationMessage;
  final String password;
  final String? passwordValidationMessage;
  final bool obscureText;
  final bool isRememberMe;

  LoginState({
    this.isLoading = false,
    this.phoneNumber = '',
    this.phoneNumberValidationMessage,
    this.password = '',
    this.passwordValidationMessage,
    this.obscureText = true,
    this.isRememberMe = false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? phoneNumber,
    String? phoneNumberValidationMessage,
    String? password,
    String? passwordValidationMessage,
    bool? obscureText,
    bool? isRememberMe,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      phoneNumberValidationMessage: phoneNumberValidationMessage,
      password: password ?? this.password,
      passwordValidationMessage: passwordValidationMessage,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}
