import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/nav_bar/controller/nav_bar_controller.dart';
import 'package:tzwad_mobile/features/nav_bar/controller/nav_bar_state.dart';

final navBarControllerProvider = NotifierProvider.autoDispose<NavBarController, NavBarState>(
  () {
    return NavBarController();
  },
);
