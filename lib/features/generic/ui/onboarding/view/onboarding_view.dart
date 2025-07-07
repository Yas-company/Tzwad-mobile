import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_change_language_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/providers/onboarding_controller_provider.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/view/widgets/onboarding_view_body.dart';


class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      appBar: AppBar(
        leading: Consumer(
          builder: (context, ref, child) {
            return TextButton(
              onPressed: () => _onPressedSkipButton(context, ref),
              child: Text(
                'تخطي',
                style: StyleManager.getRegularStyle(
                  color: ColorManager.colorBlack1,
                ).copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            );
          },
        ),
        leadingWidth: 100,
        actions: [
          const AppButtonChangeLanguageWidget(),
        ],
      ),
      body: const OnboardingViewBody(),
    );
  }

  _onPressedSkipButton(BuildContext context, WidgetRef ref) {
    ref.read(onboardingControllerProvider.notifier).setOnBoardingScreenViewed();
    context.goNamed(AppRoutes.loginBuyerRoute);
  }
}
