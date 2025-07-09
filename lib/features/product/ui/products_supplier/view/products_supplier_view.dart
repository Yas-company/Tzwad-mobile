import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart' show AssetsManager;
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart' show StyleManager;
import 'package:tzwad_mobile/core/routes/app_routes.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/product/models/supplier_categories_response_model.dart';
import 'package:tzwad_mobile/features/product/providers/supplier_categories_provider.dart';

class ProductsSupplierView extends ConsumerStatefulWidget {
  const ProductsSupplierView({super.key});

  @override
  ConsumerState<ProductsSupplierView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends ConsumerState<ProductsSupplierView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(productSupplierControllerProvider.notifier).getSupplierCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppScaffoldWidget(
      body: ProductsSupplierViewBody(),
    );
  }

}

class ProductsSupplierViewBody extends ConsumerWidget {
  const ProductsSupplierViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.getProductsByCategoryDataState,
      ),
    );

    final searchQuery = ref.watch(supplierSearchQueryProvider);
    final categories = ref.watch(
      productSupplierControllerProvider.select(
            (state) => state.products,
      ),
    );

    final failure = ref.read(
      productSupplierControllerProvider.select(
            (state) => state.failure,
      ),
    );

    // 🔍 Filter based on search query
    final filteredCategories = categories.where((cat) {
      final name = cat.name?.toLowerCase() ?? '';
      return name.contains(searchQuery.toLowerCase());
    }).toList();

    switch (state) {
      case DataState.loading:
        return Column(
          children: [
            headerSection(context, ref),
            Expanded(
              child: Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.all(12),
                  itemBuilder: (context, index) => loadingCategory(),
                ),
              ),
            ),
          ],
        );
      case DataState.success:
        return Column(
          children: [
            headerSection(context, ref),
            Expanded(
              child: filteredCategories.isEmpty
                  ? const AppEmptyWidget(message: 'لا توجد نتائج مطابقة.')
                  : ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (ctx, i) =>
                    categoryItem(filteredCategories[i]),
              ),
            ),
          ],
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'لا توجد تصنيفات.',
          ),
        );
      case DataState.failure:
        return Center(
          child: AppFailureWidget(
            failure: failure,
          ),
        );
      default:
        return const SizedBox();
    }
  }


  Widget headerSection(BuildContext context, WidgetRef ref) {
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
                            color: ColorManager.whiteGrey, fontSize: 18),
                      ),
                      Text(
                        'التصنيفات',
                        style: StyleManager.getRegularStyle(
                            color: ColorManager.whiteGrey, fontSize: 14),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(isSearchVisibleProvider.notifier).state = !isSearchVisible;
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: ColorManager.colorPrimary3,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(isSearchVisible?Icons.clear:Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (isSearchVisible)
                Padding(
                  padding: const EdgeInsets.only(bottom:14),
                  child: TextField(
                    onChanged: (val) => ref
                        .read(supplierSearchQueryProvider.notifier)
                        .state = val,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'ابحث عن تصنيف...',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
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
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        height: 45,
                        width: 40,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: ColorManager.colorPrimary,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.grid_view, color: Colors.white),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 10, left: 6, right: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'التصنيفات',
                              style: StyleManager.getRegularStyle(
                                  color: ColorManager.colorWhite2, fontSize: 14),
                            ),
                            Text(
                              '1303',
                              style: StyleManager.getBoldStyle(
                                  color: ColorManager.colorBlack1, fontSize: 28),
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
                            final result =
                            await context.push(AppRoutes.addProductSupplierView);
                            if (result == true) {
                              ref
                                  .read(productSupplierControllerProvider.notifier)
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

  Widget categoryItem(SupplierCategories category){
    return Container(
      margin: const EdgeInsets.only(left:16,right:16,top:18,bottom:2),
      decoration:BoxDecoration(color:ColorManager.colorWhite3,
      border: Border.all(color:ColorManager.cardGreyHint.withOpacity(0.1))),
      child: ListTile(
          trailing: const Padding(
            padding: EdgeInsets.only(bottom:10),
            child: Icon(Icons.arrow_forward,color:ColorManager.colorBlack1,size:24,),
          ),
        title: Row(
          children: [
            Text(category.name??'',style:StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
                fontSize:16
            ),),
            const SizedBox(width: 6),
            Container(
              padding:const EdgeInsets.symmetric(horizontal:10,vertical:4),
              decoration:BoxDecoration(
                  color: ColorManager.colorSecondary,
                  borderRadius:BorderRadius.circular(10)
              ),child: Text(
                  category.productsCount.toString(),
                  style:StyleManager.getRegularStyle(
                    color:Colors.white,
                    fontSize:16,
                  )
              ),),
          ],
        ),
        subtitle: Text(
          category.field?.name??'',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget loadingCategory(){
    return Container(
      margin: const EdgeInsets.only(left:16,right:16,top:18,bottom:2),
      decoration:BoxDecoration(color:ColorManager.colorWhite3,
          border: Border.all(color:ColorManager.cardGreyHint.withOpacity(0.1))),
      child: ListTile(
        trailing: const Padding(
          padding: EdgeInsets.only(bottom:10),
          child: Icon(Icons.arrow_forward,color:ColorManager.colorBlack1,size:24,),
        ),
        title: Row(
          children: [
            Text('name',style:StyleManager.getMediumStyle(
                color: ColorManager.colorBlack1,
                fontSize:16
            ),),
            const SizedBox(width: 6),
            Container(
              padding:const EdgeInsets.symmetric(horizontal:10,vertical:4),
              decoration:BoxDecoration(
                  color: ColorManager.colorSecondary,
                  borderRadius:BorderRadius.circular(10)
              ),child: Text(
                '10'.toString(),
                style:StyleManager.getRegularStyle(
                  color:Colors.white,
                  fontSize:16,
                )
            ),),
          ],
        ),
        subtitle: const Text('field',
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

