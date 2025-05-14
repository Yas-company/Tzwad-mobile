import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class OtpState {
  final DataState submitVerifyOtpDataState;
  final String otp;
  final String otpValidationMessage;
  final Failure? failure;

  OtpState({
    this.submitVerifyOtpDataState = DataState.initial,
    this.otp = '',
    this.otpValidationMessage = '',
    this.failure,
  });

  OtpState copyWith({
    DataState? submitVerifyOtpDataState,
    String? otp,
    String? otpValidationMessage,
    Failure? failure,
  }) {
    return OtpState(
      submitVerifyOtpDataState: submitVerifyOtpDataState ?? this.submitVerifyOtpDataState,
      otp: otp ?? this.otp,
      otpValidationMessage: otpValidationMessage ?? this.otpValidationMessage,
      failure: failure ?? this.failure,
    );
  }
}
