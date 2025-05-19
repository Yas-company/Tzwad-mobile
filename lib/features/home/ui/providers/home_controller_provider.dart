import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/home/ui/controller/home_controller.dart';
import 'package:tzwad_mobile/features/home/ui/controller/home_state.dart';

final homeControllerProvider = NotifierProvider.autoDispose<HomeController, HomeState>(
  () {
    return HomeController();
  },
);
