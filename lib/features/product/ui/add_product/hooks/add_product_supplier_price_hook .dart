import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductPriceController({
  required WidgetRef ref,
}) {
  return use(_AddProductPriceControllerHook(ref: ref));
}

class _AddProductPriceControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductPriceControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductPriceControllerHookState();
}

class _AddProductPriceControllerHookState
    extends HookState<TextEditingController, _AddProductPriceControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {
    final text = _controller.text;
    final notifier = hook.ref.read(addProductControllerProvider.notifier);
    final currentText = hook.ref.read(addProductControllerProvider).price;

    // Optional: prevent redundant updates
    if (text != currentText) {
      notifier.changePrice(text);
    }
    // hook.ref.read(addProductControllerProvider.notifier).changePrice(_controller.text);
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
