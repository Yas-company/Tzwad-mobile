import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

ScrollController useAutoLoadScrollController({
  required bool hasMore,
  required bool isLoading,
  required VoidCallback onLoadMore,
  double offsetBeforeEnd = 300,
}) {
  final scrollController = useScrollController();

  useEffect(() {
    void listener() {
      final position = scrollController.position;
      if (position.pixels >= position.maxScrollExtent - offsetBeforeEnd &&
          hasMore &&
          !isLoading) {
        onLoadMore();
      }
    }

    scrollController.addListener(listener);
    return () => scrollController.removeListener(listener);
  }, [scrollController, hasMore, isLoading]);

  return scrollController;
}
