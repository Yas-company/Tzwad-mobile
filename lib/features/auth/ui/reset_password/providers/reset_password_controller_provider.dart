import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/controller/reset_password_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/controller/reset_password_state.dart';

final resetPasswordControllerProvider = NotifierProvider.autoDispose<ResetPasswordController, ResetPasswordState>(
  () {
    return ResetPasswordController();
  },
);
