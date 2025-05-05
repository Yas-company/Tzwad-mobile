class OnboardingState {
  final int index;
  final double page;

  OnboardingState({
    this.index = 0,
    this.page = 0.0,
  });

  OnboardingState copyWith({
    int? index,
    double? page,
  }) {
    return OnboardingState(
      index: index ?? this.index,
      page: page ?? this.page,
    );
  }
}
