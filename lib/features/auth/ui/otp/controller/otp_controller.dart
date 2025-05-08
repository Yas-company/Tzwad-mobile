import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/services/app_prefs/app_preferences_provider.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'otp_state.dart';

class OtpController extends AutoDisposeNotifier<OtpState> {
  @override
  OtpState build() {
    state = _onInit();
    generateOtp();
    return state;
  }

  OtpState _onInit() => OtpState();

  void changeOtpCode(String otp) {
    state = state.copyWith(
      otp: otp,
      otpValidationMessage: otp.validateOtpCode,
    );
  }

  void generateOtp() async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.generateOtp(
      phoneNumber: '',
    );
  }

  void verifyOtp() async {
    final repository = ref.read(authRepositoryProvider);
    final appPrefs = ref.read(appPreferencesProvider);
    final otpValidationMessage = state.otp.validateOtpCode;
    if (otpValidationMessage.isNotEmpty) {
      state = state.copyWith(
        otpValidationMessage: otpValidationMessage,
      );
      return;
    }
    state = state.copyWith(
      submitVerifyOtpDataState: DataState.loading,
    );
    final result = await repository.verifyOtp(
      phoneNumber: '',
      otp: state.otp,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitVerifyOtpDataState: DataState.failure,
        failure: l,
      ),
      (r) {
        appPrefs.setUserLogged();
        appPrefs.setToken(r.token ?? '');
        state = state.copyWith(
          submitVerifyOtpDataState: DataState.success,
          user: r,
        );
      },
    );
  }
}
