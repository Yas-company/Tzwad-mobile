import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/reset_password/providers/reset_password_controller_provider.dart';

TextEditingController useResetPasswordRePasswordController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _ResetPasswordRePasswordControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _ResetPasswordRePasswordControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _ResetPasswordRePasswordControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _ResetPasswordRePasswordControllerHookState();
}

class _ResetPasswordRePasswordControllerHookState extends HookState<TextEditingController, _ResetPasswordRePasswordControllerHook> {
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
  void didUpdateHook(_ResetPasswordRePasswordControllerHook oldHook) {
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
    hook.ref.read(resetPasswordControllerProvider.notifier).changeRePassword(
          _controller.text,
        );
  }
}
