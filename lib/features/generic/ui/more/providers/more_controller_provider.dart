import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/generic/ui/more/controller/more_controller.dart';
import 'package:tzwad_mobile/features/generic/ui/more/controller/more_state.dart';

final moreControllerProvider = NotifierProvider.autoDispose<MoreController, MoreState>(
  () {
    return MoreController();
  },
);
