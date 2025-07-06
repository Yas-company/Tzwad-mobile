import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/controller/login_buyer_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/controller/login_buyer_state.dart';

final loginBuyerControllerProvider = NotifierProvider.autoDispose<LoginBuyerController, LoginBuyerState>(
  () {
    return LoginBuyerController();
  },
);
