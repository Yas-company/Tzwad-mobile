import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/forget_password/providers/forget_password_controller_provider.dart';

TextEditingController useForgetPasswordPhoneNumberController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _ForgetPasswordPhoneNumberControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _ForgetPasswordPhoneNumberControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _ForgetPasswordPhoneNumberControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _ForgetPasswordPhoneNumberControllerHookState();
}

class _ForgetPasswordPhoneNumberControllerHookState extends HookState<TextEditingController, _ForgetPasswordPhoneNumberControllerHook> {
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
  void didUpdateHook(_ForgetPasswordPhoneNumberControllerHook oldHook) {
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
    hook.ref.read(forgetPasswordControllerProvider.notifier).changePhoneNumber(
          _controller.text,
        );
  }
}
