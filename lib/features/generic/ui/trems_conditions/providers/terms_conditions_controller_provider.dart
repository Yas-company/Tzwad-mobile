import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/controller/terms_conditions_controller.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/controller/terms_conditions_state.dart';

final termsConditionsControllerProvider = NotifierProvider.autoDispose<TermsConditionsController, TermsConditionsState>(
  () {
    return TermsConditionsController();
  },
);
