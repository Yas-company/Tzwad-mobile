import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/controller/change_password_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/controller/change_password_state.dart';

final changePasswordControllerProvider = NotifierProvider.autoDispose<ChangePasswordController, ChangePasswordState>(
  () {
    return ChangePasswordController();
  },
);
