import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/features/generic/ui/onboarding/providers/onboarding_controller_provider.dart';

PageController useOnboardingPageController({
  required WidgetRef ref,
}) {
  return use(
    _OnboardingPageControllerHook(
      ref: ref,
    ),
  );
}

class _OnboardingPageControllerHook extends Hook<PageController> {
  final WidgetRef ref;

  const _OnboardingPageControllerHook({
    required this.ref,
  });

  @override
  HookState<PageController, Hook<PageController>> createState() => _OnboardingPageControllerHookState();
}

class _OnboardingPageControllerHookState extends HookState<PageController, _OnboardingPageControllerHook> {
  late final PageController _pageController;

  @override
  void initHook() {
    super.initHook();

    _pageController = PageController();
    _pageController.addListener(
      listener,
    );
  }

  @override
  PageController build(
    BuildContext context,
  ) {
    return _pageController;
  }

  @override
  void didUpdateHook(_OnboardingPageControllerHook oldHook) {
    super.didUpdateHook(oldHook);
  }

  @override
  void dispose() {
    _pageController.removeListener(
      listener,
    );
    _pageController.dispose();

    super.dispose();
  }

  void listener() {
    double page = _pageController.page ?? 0.0;
    hook.ref.read(onboardingControllerProvider.notifier).updatePage(page);
  }
}
