import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/controller/otp_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/controller/otp_state.dart';

final otpControllerProvider = NotifierProvider.autoDispose<OtpController, OtpState>(
  () {
    return OtpController();
  },
);
