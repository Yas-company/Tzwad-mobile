import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'nav_bar_state.dart';

class NavBarController extends AutoDisposeNotifier<NavBarState> {
  @override
  NavBarState build() {
    state = _onInit();
    return state;
  }

  NavBarState _onInit() => NavBarState();

  void changeIndex(int index) {
    state = state.copyWith(
      currentIndex: index,
    );
  }

  void incrementCountCart() {
    state = state.copyWith(
      countCart: state.countCart + 1,
    );
  }

  void decrementCountCart() {
    state = state.copyWith(
      countCart: state.countCart - 1,
    );
  }
}
