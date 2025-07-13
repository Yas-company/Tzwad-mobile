import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/file_upload/picked_file_controller.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/features/product/models/add_supplier_product_request_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class SupplierHeaderSection extends ConsumerWidget {
  const SupplierHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchVisible = ref.watch(isSearchVisibleProvider);
    final searchQuery = ref.watch(supplierSearchQueryProvider);

    return Column(
      children: [
        Container(
          color: ColorManager.colorPrimary,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'المنتجات',
                        style: StyleManager.getBoldStyle(
                          color: ColorManager.whiteGrey,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        'التصنيفات',
                        style: StyleManager.getRegularStyle(
                          color: ColorManager.whiteGrey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(isSearchVisibleProvider.notifier).state =
                      !isSearchVisible;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.colorPrimary3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        isSearchVisible ? Icons.clear : Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (isSearchVisible)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: TextField(
                    onChanged: (val) => ref
                        .read(supplierSearchQueryProvider.notifier)
                        .state = val,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'ابحث عن تصنيف...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 40,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.colorPrimary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.grid_view, color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 6, right: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'التصنيفات',
                            style: StyleManager.getRegularStyle(
                              color: ColorManager.colorWhite2,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            '1303',
                            style: StyleManager.getBoldStyle(
                              color: ColorManager.colorBlack1,
                              fontSize: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 90,
                      height: 44,
                      child: AppButtonWidget(
                        backgroundColor: ColorManager.colorSecondary,
                        label: 'إضافة',
                        onPressed: () async {
                          ref.read(isInitializedProvider.notifier).state = false;
                          ref.read(pickedFileProvider.notifier).reset();
                          ref.read(selectedSupplierFieldIdProvider.notifier).resetTo(0);
                          final request =
                          AddSupplierProductRequestModel(isEdit: false);
                          final result = await context.push(
                            AppRoutes.addProductSupplierView,
                            extra: request,
                          );

                          if (result == true) {
                            ref.read(productSupplierControllerProvider.notifier)
                                .getSupplierCategory();
                          }
                        },
                        assetsIcon: AssetsManager.icAdd,
                        assetColor: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
