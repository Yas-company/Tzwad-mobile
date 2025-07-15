import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/network/api_service_provider.dart';
import 'package:tzwad_mobile/features/product/repository/product_supplier_repository.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/product_supplier_controller.dart';
import 'package:tzwad_mobile/features/product/ui/products_supplier/product_supplier_state.dart';


final supplierSearchQueryProvider = StateProvider<String>((ref) => '');

final isSearchVisibleProvider = StateProvider<bool>((ref) => false);


final productSupplierRepositoryProvider = Provider.autoDispose<ProductSupplierRepository>((ref) {
    final apiService = ref.read(
      apiServiceProvider,
    );
    return ProductSupplierRepository(apiService: apiService,);
  },
);


final productSupplierControllerProvider = NotifierProvider.autoDispose<ProductSupplierController, ProductSupplierState>(
      () {
    return ProductSupplierController();
  },
);

final arabicNameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final englishNameControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final isFormValidProvider = StateProvider.autoDispose<bool>((ref) => false);


final imageProvider = StateProvider.autoDispose<String>((ref) => '');

final isInitializedProvider = StateProvider<bool>((ref) => false);

final selectedSupplierFieldIdProvider =
StateNotifierProvider<SelectedFieldIdNotifier, int?>((ref) => SelectedFieldIdNotifier(),);
// final englishNameControllerProvider = Provider<TextEditingController>((ref) {
//   final controller = TextEditingController();
//   ref.onDispose(() => controller.dispose());
//   return controller;
// });


