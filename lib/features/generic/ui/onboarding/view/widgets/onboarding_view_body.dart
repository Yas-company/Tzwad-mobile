import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_dot_indicator_widgets.dart';
import 'package:tzwad_mobile/core/app_widgets/app_ripple_widget.dart';
import 'package:tzwad_mobile/core/extension/context_extension.dart';
import 'package:tzwad_mobile/core/extension/string_extension.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/generic/models/onboarding_model.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/controller/onboarding_controller.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/hooks/onboarding_page_controller_hook.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/providers/onboarding_controller_provider.dart';

import 'item_onboarding.dart';

class OnboardingViewBody extends HookConsumerWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = useOnboardingPageController(
      ref: ref,
    );
    final controller = ref.watch(
      onboardingControllerProvider.notifier,
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
          const Spacer(),
          SizedBox(
            height: context.getHeight * 0.5,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) => ItemOnboarding(
                onBoarding: onboardingList(context)[index],
              ),
              itemCount: onboardingList(context).length,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int index = 0; index < onboardingList(context).length; index++)
                AppDotIndicatorWidgets(
                  currentPage: currentPage,
                  index: index,
                  colorFocus: ColorManager.colorPrimary,
                  colorUnFocus: ColorManager.colorGreyDots,
                ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildButton(
                onTap: () => _onPressedLastButton(context, currentPage.toInt(), pageController, controller),
                color: ColorManager.colorPrimary,
                isLeftButton: false,
              ),
              const Spacer(),
              _buildButton(
                onTap: () => _onPressedNextButton(context, currentPage.toInt(), pageController, controller),
                color: ColorManager.colorSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<OnBoardingModel> onboardingList(context) => [
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding1,
          title: AppStrings.strPage1Title.tr(context),
          description: AppStrings.strPage1Desc.tr(context),
        ),
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding2,
          title: AppStrings.strPage2Title.tr(context),
          description: AppStrings.strPage2Desc.tr(context),
        ),
        OnBoardingModel(
          imagePath: AssetsManager.imgOnboarding3,
          title: AppStrings.strPage3Title.tr(context),
          description: AppStrings.strPage3Desc.tr(context),
        ),
      ];

  Widget _buildButton({
    required Function onTap,
    required Color color,
    bool isLeftButton = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.s8),
        border: Border.all(
          color: color,
          width: AppSize.s1,
        ),
      ),
      child: AppRippleWidget(
        radius: AppSize.s8,
        onTap: () => onTap(),
        child: Container(
          margin: const EdgeInsets.all(AppPadding.p2),
          width: AppSize.s50,
          height: AppSize.s50,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: isLeftButton ? 0 : 3.14,
            child: const Icon(
              Icons.keyboard_arrow_left_rounded,
              color: ColorManager.colorWhite1,
            ),
          ),
        ),
      ),
    );
  }

  _onPressedNextButton(BuildContext context, int index, PageController pageController, OnboardingController controller) {
    'Mohammad Alhaj Ali'.log();
    if (index < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    } else {
      controller.setOnBoardingScreenViewed();
      context.pushReplacementNamed(AppRoutes.loginBuyerRoute);
    }
  }

  _onPressedLastButton(BuildContext context, int index, PageController pageController, OnboardingController controller) {
    if (index > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
