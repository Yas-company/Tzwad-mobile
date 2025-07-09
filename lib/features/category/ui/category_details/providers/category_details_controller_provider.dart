import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tzwad_mobile/features/category/ui/category_details/controller/category_details_controller.dart';
import 'package:tzwad_mobile/features/category/ui/category_details/controller/category_details_state.dart';

final categoryDetailsControllerProvider = NotifierProvider.autoDispose<CategoryDetailsController,
    CategoryDetailsState>(
  () {
    return CategoryDetailsController();
  },
);
