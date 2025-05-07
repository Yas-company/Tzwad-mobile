import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login/providers/login_controller_provider.dart';

TextEditingController useLoginPhoneNumberController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _PhoneNumberControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _PhoneNumberControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _PhoneNumberControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _PhoneNumberControllerHookState();
}

class _PhoneNumberControllerHookState extends HookState<TextEditingController, _PhoneNumberControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController(
      text: hook.initialText,
    );
    _controller.addListener(
      listener,
    );
  }

  @override
  TextEditingController build(BuildContext context) {
    return _controller;
  }

  @override
  void didUpdateHook(_PhoneNumberControllerHook oldHook) {
    super.didUpdateHook(oldHook);
  }

  @override
  void dispose() {
    _controller.removeListener(
      listener,
    );
    _controller.dispose();

    super.dispose();
  }

  void listener() {
    hook.ref.read(loginControllerProvider.notifier).changePhoneNumber(
          _controller.text,
        );
  }
}
