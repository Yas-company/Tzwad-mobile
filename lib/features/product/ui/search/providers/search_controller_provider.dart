import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/product/ui/search/controller/search_controller.dart';
import 'package:tzwad_mobile/features/product/ui/search/controller/search_state.dart';

final searchControllerProvider = NotifierProvider.autoDispose<SearchController, SearchState>(
  () {
    return SearchController();
  },
);
