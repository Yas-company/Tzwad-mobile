import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/add_product_supplier_controller.dart';
import '../providers/add_product_supplier_controller_provider.dart';

TextEditingController useAddProductPiecesController({
  required WidgetRef ref,
}) {
  return use(_AddProductPiecesControllerHook(ref: ref));
}

class _AddProductPiecesControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _AddProductPiecesControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _AddProductPiecesControllerHookState();
}

class _AddProductPiecesControllerHookState
    extends HookState<TextEditingController, _AddProductPiecesControllerHook> {
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
    final currentText = hook.ref.read(addProductControllerProvider).pieces;

    // Optional: prevent redundant updates
    if (text != currentText) {
      notifier.changePieces(text);
    }
    // hook.ref.read(addProductControllerProvider.notifier).changePieces(_controller.text);
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
