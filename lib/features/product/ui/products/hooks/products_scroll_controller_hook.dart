import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/products/providers/product_controller_provider.dart';

ScrollController useProductsScrollController({
  required WidgetRef ref,
}) {
  return use(
    _ProductsScrollControllerHook(
      ref: ref,
    ),
  );
}

class _ProductsScrollControllerHook extends Hook<ScrollController> {
  final WidgetRef ref;

  const _ProductsScrollControllerHook({
    required this.ref,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _ProductsScrollControllerHookState();
}

class _ProductsScrollControllerHookState extends HookState<ScrollController, _ProductsScrollControllerHook> {
  late final ScrollController _scrollController;

  @override
  void initHook() {
    super.initHook();

    _scrollController = ScrollController();
    _scrollController.addListener(
      listener,
    );
  }

  @override
  ScrollController build(
    BuildContext context,
  ) {
    return _scrollController;
  }

  @override
  void didUpdateHook(_ProductsScrollControllerHook oldHook) {
    super.didUpdateHook(oldHook);
  }

  @override
  void dispose() {
    _scrollController.removeListener(
      listener,
    );
    _scrollController.dispose();

    super.dispose();
  }

  void listener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      hook.ref.read(productsControllerProvider.notifier).getPage();
    }
  }
}
