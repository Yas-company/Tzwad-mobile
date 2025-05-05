import 'package:flutter/material.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/widgets/onboarding_view_body.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      body: OnboardingViewBody(),
    );
  }
}
