import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/auth/providers/auth_repository_provider.dart';
import 'more_state.dart';

class MoreController extends AutoDisposeNotifier<MoreState> {
  @override
  MoreState build() {
    state = _onInit();
    return state;
  }

  MoreState _onInit() => MoreState();

  void deleteAccount() async {
    final repository = ref.read(authRepositoryProvider);
    state = state.copyWith(
      submitDeleteAccountDataState: DataState.loading,
    );
    final result = await repository.deleteAccount();
    result.fold(
      (l) => state = state.copyWith(
        submitDeleteAccountDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitDeleteAccountDataState: DataState.success,
      ),
    );
  }

  void logout() async {
    final repository = ref.read(authRepositoryProvider);
    state = state.copyWith(
      submitLogoutDataState: DataState.loading,
    );
    final result = await repository.logout();
    result.fold(
      (l) => state = state.copyWith(
        submitLogoutDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        submitLogoutDataState: DataState.success,
      ),
    );
  }
}
