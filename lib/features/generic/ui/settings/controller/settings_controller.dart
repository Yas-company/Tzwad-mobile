import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/user_local_data_provider.dart';
import 'package:tzwad_mobile/features/generic/providers/setting_local_data_provider.dart';
import 'package:tzwad_mobile/features/product/providers/cart_local_data_provider.dart';
import 'package:tzwad_mobile/features/product/providers/favorite_product_local_data_provider.dart';
import 'settings_state.dart';

class SettingsController extends AutoDisposeNotifier<SettingsState> {
  @override
  SettingsState build() {
    state = _onInit();
    return state;
  }

  SettingsState _onInit() => SettingsState();

  void logout() async {
    final userLocalData = ref.read(userLocalDataProvider);
    final cartLocalData = ref.read(cartLocalDataProvider);
    final favoriteProductLocalData = ref.read(favoriteProductLocalDataProvider);
    final settingLocalData = ref.read(settingLocalDataProvider);

    state = state.copyWith(
      submitLogoutDataState: DataState.loading,
    );
    try {
      await Future.wait(
        [
          userLocalData.clearBox(),
          cartLocalData.clearBox(),
          favoriteProductLocalData.clearBox(),
          settingLocalData.clearBox(),
        ],
      );
      state = state.copyWith(
        submitLogoutDataState: DataState.success,
      );
    } catch (e) {
      state = state.copyWith(
        submitLogoutDataState: DataState.failure,
      );
    }
  }
}
