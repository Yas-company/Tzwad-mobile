import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductQuantityController({
  required WidgetRef ref,
}) {
  return use(_AddProductQuantityControllerHook(ref: ref));
}

class _AddProductQuantityControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductQuantityControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductQuantityControllerHookState();
}

class _AddProductQuantityControllerHookState
    extends HookState<TextEditingController, _AddProductQuantityControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {
    hook.ref.read(addProductControllerProvider.notifier).changeQuantity(_controller.text);
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
