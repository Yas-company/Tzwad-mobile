import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

TextEditingController useRegisterPasswordController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _RegisterPasswordControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _RegisterPasswordControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _RegisterPasswordControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _RegisterPasswordControllerHookState();
}

class _RegisterPasswordControllerHookState extends HookState<TextEditingController, _RegisterPasswordControllerHook> {
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
  void didUpdateHook(_RegisterPasswordControllerHook oldHook) {
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
    hook.ref.read(registerControllerProvider.notifier).changePassword(
          _controller.text,
        );
  }
}
