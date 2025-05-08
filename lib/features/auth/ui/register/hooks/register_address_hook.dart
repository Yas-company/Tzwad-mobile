import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/register/providers/register_controller_provider.dart';

TextEditingController useRegisterAddressController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _RegisterAddressControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _RegisterAddressControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _RegisterAddressControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _RegisterAddressControllerHookState();
}

class _RegisterAddressControllerHookState extends HookState<TextEditingController, _RegisterAddressControllerHook> {
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
  void didUpdateHook(_RegisterAddressControllerHook oldHook) {
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
    hook.ref.read(registerControllerProvider.notifier).changeAddress(
          _controller.text,
        );
  }
}
