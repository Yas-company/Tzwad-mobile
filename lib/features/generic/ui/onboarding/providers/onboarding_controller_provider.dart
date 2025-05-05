import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/controller/onboarding_controller.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/controller/onboarding_state.dart';

final onboardingControllerProvider = NotifierProvider.autoDispose<OnboardingController, OnboardingState>(
  () {
    return OnboardingController();
  },
);
