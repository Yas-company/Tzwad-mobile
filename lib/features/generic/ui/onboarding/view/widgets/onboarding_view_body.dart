import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_dot_indicator_widgets.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/generic/models/onboarding_model.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/hooks/onboarding_page_controller_hook.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/providers/onboarding_controller_provider.dart';

import 'item_onboarding.dart';

class OnboardingViewBody extends HookConsumerWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useOnboardingPageController(
      ref: ref,
    );
    // final currentIndex = ref.watch(
    //   onboardingControllerProvider.select(
    //     (value) => value.index,
    //   ),
    // );

    final currentPage = ref.watch(
      onboardingControllerProvider.select(
        (value) => value.page,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemBuilder: (context, index) => ItemOnboarding(
                onBoarding: onboardingList[index],
              ),
              itemCount: onboardingList.length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < onboardingList.length; index++)
                AppDotIndicatorWidgets(
                  currentPage: currentPage,
                  index: index,
                  colorFocus: ColorManager.colorPrimary,
                  colorUnFocus: ColorManager.colorGreyDots,
                ),
            ],
          ),
          Gap(
            AppPadding.p16,
          ),
          Row(
            children: [
              Expanded(
                child: AppButtonWidget(
                  label: 'Skip',
                  onPressed: () => _onPressedSkipButton(context),
                  isExpanded: true,
                  buttonType: ButtonType.outline,
                ),
              ),
              Gap(
                AppPadding.p16,
              ),
              Expanded(
                child: AppButtonWidget(
                  label: 'Continue',
                  onPressed: () => _onPressedContinueButton(context, currentPage.toInt(), controller),
                  isExpanded: true,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<OnBoardingModel> get onboardingList => [
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding1,
          title: 'Save up to 30% off',
          description: 'Save up to 30% off many groceries, this over will be end very soon . So buy you food quickly',
        ),
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding2,
          title: 'Fresh Groceries',
          description: 'Buy  fresh  Groceries and organic food from us.We have so many groceries in our Store',
        ),
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding3,
          title: 'Easy Shopping',
          description: 'Save up to 30% off many groceries, this over will be end very soon . So buy you food quickly',
        ),
      ];

  _onPressedSkipButton(BuildContext context) {
    context.go(AppRoutes.loginRoute);
  }

  _onPressedContinueButton(BuildContext context, int index, PageController controller) {
    if (index < onboardingList.length - 1) {
      controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      context.go(AppRoutes.loginRoute);
    }
  }
}
