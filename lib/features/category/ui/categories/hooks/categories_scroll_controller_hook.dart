import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useCategoriesScrollController({
  required Function()? onLoadMore,
}) {
  return use(
    _CategoriesScrollControllerHook(
      onLoadMore: onLoadMore,
    ),
  );
}

class _CategoriesScrollControllerHook extends Hook<ScrollController> {
  final Function()? onLoadMore;

  const _CategoriesScrollControllerHook({
    required this.onLoadMore,
  });

  @override
  HookState<ScrollController, Hook<ScrollController>> createState() => _CategoriesScrollControllerHookState();
}

class _CategoriesScrollControllerHookState extends HookState<ScrollController, _CategoriesScrollControllerHook> {
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
  void didUpdateHook(_CategoriesScrollControllerHook oldHook) {
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
