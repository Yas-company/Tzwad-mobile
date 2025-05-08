import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/controller/forget_password_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/controller/forget_password_state.dart';

final forgetPasswordControllerProvider = NotifierProvider.autoDispose<ForgetPasswordController, ForgetPasswordState>(
  () {
    return ForgetPasswordController();
  },
);
