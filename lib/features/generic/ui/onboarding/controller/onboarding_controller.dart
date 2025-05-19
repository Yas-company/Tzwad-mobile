import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';
import 'onboarding_state.dart';

class OnboardingController extends AutoDisposeNotifier<OnboardingState> {
  @override
  OnboardingState build() {
    state = _onInit();
    return state;
  }

  OnboardingState _onInit() => OnboardingState();

  void updatePage(double page) {
    state = state.copyWith(
      page: page,
    );
  }

  void changeIndex(int index) {
    state = state.copyWith(
      index: index,
    );
  }

  void nextPage() {
    state = state.copyWith(
      index: state.index + 1,
    );
  }

  void previousPage() {
    state = state.copyWith(
      index: state.index - 1,
    );
  }

  void setOnBoardingScreenViewed() {
    final settingLocalData = ref.read(
      settingLocalDataProvider,
    );

    settingLocalData.setOnBoardingScreenViewed();
  }
}
