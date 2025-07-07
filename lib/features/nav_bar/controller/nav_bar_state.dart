class NavBarState {
  final int currentIndex;
  final double page;
  final int countCart;

  NavBarState({
    this.currentIndex = 0,
    this.page = 0.0,
    this.countCart = 0,
  });

  NavBarState copyWith({
    int? currentIndex,
    double? page,
    int? countCart,
  }) {
    return NavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
      page: page ?? this.page,
      countCart: countCart ?? this.countCart,
    );
  }
}
