import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/extension/validation_extension.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/models/otp_flow_type.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'otp_state.dart';

class OtpController extends AutoDisposeNotifier<OtpState> {
  @override
  OtpState build() {
    state = _onInit();
    return state;
  }

  OtpState _onInit() => OtpState();

  void changeOtpCode(String otp) {
    state = state.copyWith(
      otp: otp,
      otpValidationMessage: otp.validateOtpCode,
    );
  }

  void verifyOtp(String phoneNumber, OtpFlowType otpFlowType) async {
    final repository = ref.read(authRepositoryProvider);
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
      phoneNumber: phoneNumber,
      otp: state.otp,
      otpFlowType: otpFlowType,
    );
    result.fold(
      (l) => state = state.copyWith(
        submitVerifyOtpDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitVerifyOtpDataState: DataState.success,
      ),
    );
  }
}
