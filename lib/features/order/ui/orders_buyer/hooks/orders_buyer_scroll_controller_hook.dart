import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useOrdersBuyerScrollController({
  required Function()? onLoadMore,
}) {
  return use(
    _OrdersBuyerScrollControllerHook(
      onLoadMore: onLoadMore,
    ),
  );
}

class _OrdersBuyerScrollControllerHook extends Hook<ScrollController> {
  final Function()? onLoadMore;

  const _OrdersBuyerScrollControllerHook({
    required this.onLoadMore,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _OrdersBuyerScrollControllerHookState();
}

class _OrdersBuyerScrollControllerHookState extends HookState<ScrollController, _OrdersBuyerScrollControllerHook> {
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
  void didUpdateHook(_OrdersBuyerScrollControllerHook oldHook) {
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
