import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/auth/ui/login_supplier/providers/login_supplier_controller_provider.dart';

TextEditingController useLoginSupplierPasswordController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _LoginSupplierPasswordControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _LoginSupplierPasswordControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _LoginSupplierPasswordControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _LoginSupplierPasswordControllerHookState();
}

class _LoginSupplierPasswordControllerHookState extends HookState<TextEditingController, _LoginSupplierPasswordControllerHook> {
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
  void didUpdateHook(_LoginSupplierPasswordControllerHook oldHook) {
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
    hook.ref.read(loginSupplierControllerProvider.notifier).changePassword(
          _controller.text,
        );
  }
}
