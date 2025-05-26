import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/search/providers/search_controller_provider.dart';

TextEditingController useSearchFieldController({
  required WidgetRef ref,
  String initialText = '',
}) {
  return use(
    _SearchFieldControllerHook(
      ref: ref,
      initialText: initialText,
    ),
  );
}

class _SearchFieldControllerHook extends Hook<TextEditingController> {
  final WidgetRef ref;
  final String initialText;

  const _SearchFieldControllerHook({
    required this.ref,
    required this.initialText,
  });

  @override
  HookState<TextEditingController, Hook<TextEditingController>> createState() => _SearchFieldControllerHookState();
}

class _SearchFieldControllerHookState extends HookState<TextEditingController, _SearchFieldControllerHook> {
  late final TextEditingController _controller;

  @override
  void initHook() {
    super.initHook();
    _controller = TextEditingController(
      text: hook.initialText,
    );
    _controller.addListener(
      listener,
    );
  }

  @override
  TextEditingController build(BuildContext context) {
    return _controller;
  }

  @override
  void didUpdateHook(_SearchFieldControllerHook oldHook) {
    super.didUpdateHook(oldHook);
  }

  @override
  void dispose() {
    _controller.removeListener(
      listener,
    );
    _controller.dispose();

    super.dispose();
  }

  void listener() {
    hook.ref.read(searchControllerProvider.notifier).filterProducts(
          search: _controller.text,
        );
  }
}
