import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useSuppliersScrollController({
  required Function()? onLoadMore,
}) {
  return use(
    _SuppliersScrollControllerHook(
      onLoadMore: onLoadMore,
    ),
  );
}

class _SuppliersScrollControllerHook extends Hook<ScrollController> {
  final Function()? onLoadMore;

  const _SuppliersScrollControllerHook({
    required this.onLoadMore,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _SuppliersScrollControllerHookState();
}

class _SuppliersScrollControllerHookState extends HookState<ScrollController, _SuppliersScrollControllerHook> {
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
  void didUpdateHook(_SuppliersScrollControllerHook oldHook) {
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
