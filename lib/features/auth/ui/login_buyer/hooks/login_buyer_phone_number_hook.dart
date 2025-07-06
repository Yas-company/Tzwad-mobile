import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_buyer/providers/login_buyer_controller_provider.dart';

TextEditingController useLoginBuyerPhoneNumberController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _LoginBuyerPhoneNumberControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _LoginBuyerPhoneNumberControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _LoginBuyerPhoneNumberControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _LoginBuyerPhoneNumberControllerHookState();
}

class _LoginBuyerPhoneNumberControllerHookState extends HookState<TextEditingController, _LoginBuyerPhoneNumberControllerHook> {
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
  void didUpdateHook(_LoginBuyerPhoneNumberControllerHook oldHook) {
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
    hook.ref.read(loginBuyerControllerProvider.notifier).changePhoneNumber(
          _controller.text,
        );
  }
}
