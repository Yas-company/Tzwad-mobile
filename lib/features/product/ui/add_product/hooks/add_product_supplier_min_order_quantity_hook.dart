import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductMinOrderController({
  required WidgetRef ref,
}) {
  return use(_AddProductMinOrderControllerHook(ref: ref));
}

class _AddProductMinOrderControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductMinOrderControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductMinOrderControllerHookState();
}

class _AddProductMinOrderControllerHookState
    extends HookState<TextEditingController, _AddProductMinOrderControllerHook> {
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
    final currentText = hook.ref.read(addProductControllerProvider).minQty;

    // Optional: prevent redundant updates
    if (text != currentText) {
      notifier.changeMinOrder(text);
    }
    // hook.ref.read(addProductControllerProvider.notifier).changeMinOrder(_controller.text);
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
