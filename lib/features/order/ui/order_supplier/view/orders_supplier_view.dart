import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_empt_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_scaffold_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_svg_picture_widget.dart';
import 'package:tzwad_mobile/core/resource/assets_manager.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/font_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/supplier_orders_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/provider/supplier_order_provider.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/paginated_supplier_orders_widget.dart';
import '../widgets/supplier_order_widget.dart';

class OrdersSupplierView extends ConsumerStatefulWidget {
  const OrdersSupplierView({super.key});

  @override
  ConsumerState<OrdersSupplierView> createState() => OrdersSupplierViewState();
}

class OrdersSupplierViewState extends ConsumerState<OrdersSupplierView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(supplierOrderProvider.notifier).getSupplierOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return  AppScaffoldWidget(
      body:const OrdersSupplierViewBody(),
      floatingActionButton:  Container(height:50,
        margin: const EdgeInsets.only(bottom:14),
        child: FloatingActionButton.extended(
          shape:const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(AppSize.s8))
          ),
          onPressed: () {},backgroundColor: ColorManager.colorSecondary,
          label:Padding(
            padding: const EdgeInsets.only(top:4),
            child: Text('تصفية',style:StyleManager.getSemiBoldStyle(
              color: ColorManager.colorWhite1,
              fontSize: FontSize.s14,
            )),
          ),
          extendedIconLabelSpacing: 10,
          elevation:0.4,
          icon:const SizedBox(width:14,height:15,
            child: AppSvgPictureWidget(
              assetName: AssetsManager.icFilter,
            ),
          ),
        ),
      ),
    );
  }

}


class OrdersSupplierViewBody extends ConsumerWidget {
  const OrdersSupplierViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orders = ref.watch(
      supplierOrderProvider.select((state) => state.products,),);

    final isLoading = ref.watch(
      supplierOrderProvider.select(
            (state) => state.deleteCategoryState == DataState.loading,
      ),
    );
    final state = ref.watch(
      supplierOrderProvider.select(
            (state) => state.getProductsByCategoryDataState,
      ),
    );
    final isLoadingMore = ref.watch(
      supplierOrderProvider.select(
            (state) => state.isLoadingMore,
      ),
    );
    final failure = ref.read(
      supplierOrderProvider.select(
            (state) => state.failure,
      ),
    );
    switch (state) {
      case DataState.loading:
        return Column(
          children: [
            // AppBar(title: const Text("سجل الطلبات"),centerTitle:false,),
            Padding(
              padding: const EdgeInsets.only(left:16,right:16,top:16),
              child: Align(alignment: Alignment.centerRight,
                child: Text("سجل الطلبات",style:StyleManager.getBoldStyle(color:ColorManager.colorBlack1,
                    fontSize:AppSize.s18),),
              ),
            ),
            Expanded(
              child: PaginatedSupplierOrdersWidget(
                orders: SupplierOrdersData.generateFakeList(),
                isLoading: true,
              ),
            ),
          ],
        );

      case DataState.success:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:16,right:16,top:16),
              child: Align(alignment: Alignment.centerRight,
                child: Text("سجل الطلبات",style:StyleManager.getBoldStyle(color:ColorManager.colorBlack1,
                fontSize:AppSize.s18),),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  PaginatedSupplierOrdersWidget(
                    isLoadingMore: isLoadingMore,
                    orders: orders,
                    failure: failure,
                    onLoadMore: () => _onLoadMore(ref),
                  ),
                  if (isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        );
      case DataState.empty:
        return const Center(
          child: AppEmptyWidget(
            message: 'لا توجد بيانات.',
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
  _onLoadMore(WidgetRef ref) {
    ref.read(supplierOrderProvider.notifier).getMoreData();
  }
}
