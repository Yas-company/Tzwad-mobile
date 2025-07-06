import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register_buyer/providers/register_controller_provider.dart';

TextEditingController useRegisterBuyerNameController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _RegisterBuyerNameControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _RegisterBuyerNameControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _RegisterBuyerNameControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _RegisterBuyerNameControllerHookState();
}

class _RegisterBuyerNameControllerHookState extends HookState<TextEditingController, _RegisterBuyerNameControllerHook> {
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
  void didUpdateHook(_RegisterBuyerNameControllerHook oldHook) {
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
    hook.ref.read(registerBuyerControllerProvider.notifier).changeName(
          _controller.text,
        );
  }
}
