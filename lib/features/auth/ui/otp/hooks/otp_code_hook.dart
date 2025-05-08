import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/otp/providers/otp_controller_provider.dart';

TextEditingController useOtpCodeController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _OtpCodeControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _OtpCodeControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _OtpCodeControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _OtpCodeControllerHookState();
}

class _OtpCodeControllerHookState extends HookState<TextEditingController, _OtpCodeControllerHook> {
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
  void didUpdateHook(_OtpCodeControllerHook oldHook) {
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
    hook.ref.read(otpControllerProvider.notifier).changeOtpCode(
          _controller.text,
        );
  }
}
