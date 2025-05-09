import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class TermsConditionsState {
  final DataState getTermsConditionsDataState;
  final String htmlData;
  final Failure? failure;

  TermsConditionsState({
    this.getTermsConditionsDataState = DataState.initial,
    this.htmlData = '',
    this.failure,
  });

  TermsConditionsState copyWith({
    DataState? getTermsConditionsDataState,
    String? htmlData,
    Failure? failure,
  }) {
    return TermsConditionsState(
      getTermsConditionsDataState: getTermsConditionsDataState ?? this.getTermsConditionsDataState,
      htmlData: htmlData ?? this.htmlData,
      failure: failure ?? this.failure,
    );
  }
}
