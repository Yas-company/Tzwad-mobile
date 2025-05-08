import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'forget_password_state.dart';

class ForgetPasswordController extends AutoDisposeNotifier<ForgetPasswordState> {
  @override
  ForgetPasswordState build() {
    state = _onInit();
    return state;
  }

  ForgetPasswordState _onInit() => ForgetPasswordState();

  void changePhoneNumber(String phoneNumber) {
    state = state.copyWith(
      phoneNumber: phoneNumber,
      phoneNumberValidationMessage: phoneNumber.validatePhoneNumber,
    );
  }

  void forgetPassword() async {
    final repository = ref.read(authRepositoryProvider);
    final phoneNumberValidationMessage = state.phoneNumber.validatePhoneNumber;
    if (phoneNumberValidationMessage.isNotEmpty) {
      state = state.copyWith(
        phoneNumberValidationMessage: phoneNumberValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitForgetPasswordDataState: DataState.loading,
    );
    final result = await repository.forgetPassword(
      phoneNumber: state.phoneNumber,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitForgetPasswordDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitForgetPasswordDataState: DataState.success,
      ),
    );
  }
}
