import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/home/ui/home_buyer/controller/home_buyer_controller.dart';
import 'package:tzwad_mobile/features/home/ui/home_buyer/controller/home_buyer_state.dart';

final homeBuyerControllerProvider = NotifierProvider.autoDispose<HomeBuyerController, HomeBuyerState>(
  () {
    return HomeBuyerController();
  },
);
