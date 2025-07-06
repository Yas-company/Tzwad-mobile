import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/providers/login_supplier_controller_provider.dart';

TextEditingController useLoginSupplierPhoneNumberController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _LoginSupplierPhoneNumberControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _LoginSupplierPhoneNumberControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _LoginSupplierPhoneNumberControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _LoginSupplierPhoneNumberControllerHookState();
}

class _LoginSupplierPhoneNumberControllerHookState extends HookState<TextEditingController, _LoginSupplierPhoneNumberControllerHook> {
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
  void didUpdateHook(_LoginSupplierPhoneNumberControllerHook oldHook) {
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
    hook.ref.read(loginSupplierControllerProvider.notifier).changePhoneNumber(
          _controller.text,
        );
  }
}
