import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

TextEditingController useRegisterBuyerPhoneNumberController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _RegisterBuyerPhoneNumberControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _RegisterBuyerPhoneNumberControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _RegisterBuyerPhoneNumberControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _RegisterBuyerPhoneNumberControllerHookState();
}

class _RegisterBuyerPhoneNumberControllerHookState extends HookState<TextEditingController, _RegisterBuyerPhoneNumberControllerHook> {
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
  void didUpdateHook(_RegisterBuyerPhoneNumberControllerHook oldHook) {
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
    hook.ref.read(registerBuyerControllerProvider.notifier).changePhoneNumber(
          _controller.text,
        );
  }
}
