import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/category/ui/categories/controller/categories_controller.dart';
import 'package:tzwad_mobile/features/category/ui/categories/controller/categories_state.dart';

final categoriesControllerProvider = NotifierProvider.autoDispose<CategoriesController, CategoriesState>(
  () {
    return CategoriesController();
  },
);
