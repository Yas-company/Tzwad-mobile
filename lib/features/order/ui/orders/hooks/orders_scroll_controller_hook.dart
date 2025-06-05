import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useOrdersScrollController({
  required Function()? onLoadMore,
}) {
  return use(
    _OrdersScrollControllerHook(
      onLoadMore: onLoadMore,
    ),
  );
}

class _OrdersScrollControllerHook extends Hook<ScrollController> {
  final Function()? onLoadMore;

  const _OrdersScrollControllerHook({
    required this.onLoadMore,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _OrdersScrollControllerHookState();
}

class _OrdersScrollControllerHookState extends HookState<ScrollController, _OrdersScrollControllerHook> {
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
  void didUpdateHook(_OrdersScrollControllerHook oldHook) {
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
