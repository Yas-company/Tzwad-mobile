import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register/controller/register_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/register/controller/register_state.dart';

final registerControllerProvider = NotifierProvider.autoDispose<RegisterController, RegisterState>(
  () {
    return RegisterController();
  },
);
