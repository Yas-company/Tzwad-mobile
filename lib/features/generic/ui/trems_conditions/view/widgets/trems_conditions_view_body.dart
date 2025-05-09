import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_loading_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/generic/ui/trems_conditions/providers/terms_conditions_controller_provider.dart';

class TermsConditionsViewBody extends ConsumerWidget {
  const TermsConditionsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      termsConditionsControllerProvider.select(
        (value) => value.getTermsConditionsDataState,
      ),
    );
    final data = ref.read(
      termsConditionsControllerProvider.select(
        (value) => value.htmlData,
      ),
    );
    final failure = ref.read(
      termsConditionsControllerProvider.select(
        (value) => value.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return const AppLoadingWidget(
          color: ColorManager.colorPrimary,
        );
      case DataState.success:
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: Html(
              data: data,
            ),
          ),
        );
      case DataState.failure:
        return AppFailureWidget(
          failure: failure,
        );
      case DataState.empty:
        return const AppEmptyWidget(
          message: '',
        );
      default:
        return const SizedBox();
    }
  }
}
