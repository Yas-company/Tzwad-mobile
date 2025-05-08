import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/models/user_model.dart';

class OtpState {
  final DataState submitVerifyOtpDataState;
  final UserModel? user;
  final String otp;
  final String otpValidationMessage;
  final Failure? failure;

  OtpState({
    this.submitVerifyOtpDataState = DataState.initial,
    this.user,
    this.otp = '',
    this.otpValidationMessage = '',
    this.failure,
  });

  OtpState copyWith({
    DataState? submitVerifyOtpDataState,
    UserModel? user,
    String? otp,
    String? otpValidationMessage,
    Failure? failure,
  }) {
    return OtpState(
      submitVerifyOtpDataState: submitVerifyOtpDataState ?? this.submitVerifyOtpDataState,
      user: user ?? this.user,
      otp: otp ?? this.otp,
      otpValidationMessage: otpValidationMessage ?? this.otpValidationMessage,
      failure: failure ?? this.failure,
    );
  }
}
