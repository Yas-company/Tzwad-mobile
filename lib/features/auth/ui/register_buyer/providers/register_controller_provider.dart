import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/controller/register_buyer_controller.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/controller/register_buyer_state.dart';

final registerBuyerControllerProvider = NotifierProvider.autoDispose<RegisterBuyerController, RegisterBuyerState>(
  () {
    return RegisterBuyerController();
  },
);
