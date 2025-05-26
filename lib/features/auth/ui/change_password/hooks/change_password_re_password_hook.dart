import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/change_password/providers/change_password_controller_provider.dart';

TextEditingController useChangePasswordRePasswordController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _ChangePasswordRePasswordControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _ChangePasswordRePasswordControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _ChangePasswordRePasswordControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _ChangePasswordRePasswordControllerHookState();
}

class _ChangePasswordRePasswordControllerHookState extends HookState<TextEditingController, _ChangePasswordRePasswordControllerHook> {
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
  void didUpdateHook(_ChangePasswordRePasswordControllerHook oldHook) {
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
    hook.ref.read(changePasswordControllerProvider.notifier).changeRePassword(
          _controller.text,
        );
  }
}
