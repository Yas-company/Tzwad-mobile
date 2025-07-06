import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/providers/login_buyer_controller_provider.dart';

TextEditingController useLoginBuyerPasswordController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _LoginBuyerPasswordControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _LoginBuyerPasswordControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _LoginBuyerPasswordControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _LoginBuyerPasswordControllerHookState();
}

class _LoginBuyerPasswordControllerHookState extends HookState<TextEditingController, _LoginBuyerPasswordControllerHook> {
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
  void didUpdateHook(_LoginBuyerPasswordControllerHook oldHook) {
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
    hook.ref.read(loginBuyerControllerProvider.notifier).changePassword(
          _controller.text,
        );
  }
}
