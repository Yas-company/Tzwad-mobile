import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login/controller/login_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/login/controller/login_state.dart';

final loginControllerProvider = NotifierProvider.autoDispose<LoginController, LoginState>(
  () {
    return LoginController();
  },
);
