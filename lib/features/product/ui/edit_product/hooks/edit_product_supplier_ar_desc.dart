import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/edit_product_supplier_controller.dart';
import '../providers/edit_product_supplier_controller_provider.dart';

TextEditingController useEditProductDescArController({
  required WidgetRef ref,
}) {
  return use(_EditProductDescArControllerHook(ref: ref));
}

class _EditProductDescArControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _EditProductDescArControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _EditProductDescArControllerHookState();
}

class _EditProductDescArControllerHookState
    extends HookState<TextEditingController, _EditProductDescArControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {

    hook.ref.read(EditProductControllerProvider.notifier).changeDescAr(_controller.text);
  }

  @override
  TextEditingController build(BuildContext context) => _controller;

  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();
  }
}
