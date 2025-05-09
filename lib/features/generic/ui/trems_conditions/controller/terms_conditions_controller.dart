import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/generic/providers/generic_repository_provider.dart';
import 'terms_conditions_state.dart';

class TermsConditionsController extends AutoDisposeNotifier<TermsConditionsState> {
  @override
  TermsConditionsState build() {
    state = _onInit();
    getTermsConditions();
    return state;
  }

  TermsConditionsState _onInit() => TermsConditionsState();

  void getTermsConditions() async {
    final repository = ref.read(genericRepositoryProvider);
    state = state.copyWith(
      getTermsConditionsDataState: DataState.loading,
    );
    final result = await repository.getTermsConditions();
    result.fold(
      (l) => state = state.copyWith(
        getTermsConditionsDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        getTermsConditionsDataState: DataState.success,
        htmlData: r,
      ),
    );
  }
}
