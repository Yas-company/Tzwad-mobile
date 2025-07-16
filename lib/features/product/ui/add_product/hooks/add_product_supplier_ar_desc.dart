import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductDescArController({
  required WidgetRef ref,
}) {
  return use(_AddProductDescArControllerHook(ref: ref));
}

class _AddProductDescArControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductDescArControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductDescArControllerHookState();
}

class _AddProductDescArControllerHookState
    extends HookState<TextEditingController, _AddProductDescArControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {
    final text = _controller.text;
    final refRead = hook.ref.read;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = refRead(addProductControllerProvider.notifier);
      final currentText = refRead(addProductControllerProvider).descAr;

      if (text != currentText) {
        notifier.changeDescAr(text);
      }
    });
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
