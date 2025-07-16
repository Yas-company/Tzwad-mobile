import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controller/edit_product_supplier_controller.dart';
import '../providers/edit_product_supplier_controller_provider.dart';

TextEditingController useEditProductMinOrderController({
  required WidgetRef ref,
}) {
  return use(_EditProductMinOrderControllerHook(ref: ref));
}

class _EditProductMinOrderControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  const _EditProductMinOrderControllerHook({required this.ref});

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() =>
      _EditProductMinOrderControllerHookState();
}

class _EditProductMinOrderControllerHookState
    extends HookState<TextEditingController, _EditProductMinOrderControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController();
    _controller.addListener(_listener);
  }

  void _listener() {
    hook.ref.read(EditProductControllerProvider.notifier).changeMinOrder(_controller.text);
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
