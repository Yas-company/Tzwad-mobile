import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useSupplierProductsScrollController({
  required Function()? onLoadMore,
}) {
  return use(
    _SupplierProductsScrollControllerHook(
      onLoadMore: onLoadMore,
    ),
  );
}

class _SupplierProductsScrollControllerHook extends Hook<ScrollController> {
  final Function()? onLoadMore;

  const _SupplierProductsScrollControllerHook({
    required this.onLoadMore,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _SupplierProductsScrollControllerHookState();
}

class _SupplierProductsScrollControllerHookState extends HookState<ScrollController, _SupplierProductsScrollControllerHook> {
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
  void didUpdateHook(_SupplierProductsScrollControllerHook oldHook) {
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
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && hook.onLoadMore != null) {
      hook.onLoadMore!();
    }
  }
}
