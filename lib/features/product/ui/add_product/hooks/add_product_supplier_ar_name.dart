import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductNameArController({
  required WidgetRef ref,
}) {
  return use(_AddProductNameArControllerHook(ref: ref));
}

class _AddProductNameArControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductNameArControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductNameArControllerHookState();
}

class _AddProductNameArControllerHookState
    extends HookState<TextEditingController, _AddProductNameArControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(_listener);
    });
  }

  void _listener() {
    final text = _controller.text;
    final notifier = hook.ref.read(addProductControllerProvider.notifier);
    final currentText = hook.ref.read(addProductControllerProvider).nameAr;

    // Optional: prevent redundant updates
    if (text != currentText) {
      notifier.changeNameAr(text);
    }
    // hook.ref.read(addProductControllerProvider.notifier).changeNameAr(_controller.text);
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
