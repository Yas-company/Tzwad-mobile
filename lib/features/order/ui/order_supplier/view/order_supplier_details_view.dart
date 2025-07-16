import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/app_widgets/app_button_widget.dart';
import 'package:tzwad_mobile/core/app_widgets/app_failure_widget.dart';
import 'package:tzwad_mobile/core/resource/color_manager.dart';
import 'package:tzwad_mobile/core/resource/style_manager.dart';
import 'package:tzwad_mobile/core/resource/values_manager.dart';
import 'package:tzwad_mobile/core/routes/app_args.dart';
import 'package:tzwad_mobile/features/order/models/supplier_order_details_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/provider/supplier_order_provider.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/widgets/supplier_order_details_content_widget.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';

class OrderSupplierDetailsView extends ConsumerStatefulWidget {
  const OrderSupplierDetailsView({super.key});

  @override
  ConsumerState<OrderSupplierDetailsView> createState() => OrderSupplierDetailsViewState();
}

class OrderSupplierDetailsViewState extends ConsumerState<OrderSupplierDetailsView> {
  var id = 0;

  @override
  void initState() {
    super.initState();
    id = appArgs['supplier_order_id'];
    Future.microtask(() {
        final controller = ref.read(supplierOrderDetailsControllerProvider.notifier);
        controller.showSupplierOrder(id);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("تفاصيل الطلب",style:StyleManager.getBoldStyle(color:ColorManager.colorBlack1,
            fontSize:AppSize.s18),),centerTitle: false,
      ),
      body:const OrderSupplierDetailsViewBody(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(flex:2,child: AppButtonWidget(label:'تم تسليم الطلب', onPressed:() {

            },)),
            const SizedBox(width: 12),
            Expanded(
              child: AppButtonWidget(label:'المساعدة', onPressed:() {

              },backgroundColor:Colors.white,textColor:ColorManager.colorPrimary,
                borderColor:ColorManager.colorPrimary,),
            ),
          ],
        ),
      ),
    );
  }
}



class OrderSupplierDetailsViewBody extends ConsumerWidget {
  const OrderSupplierDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      supplierOrderDetailsControllerProvider.select(
            (value) => value.getSupplierOrderDetailsDataState,
      ),
    );

    final failure = ref.watch(
      supplierOrderDetailsControllerProvider.select(
            (value) => value.failure,
      ),
    );

    final order = ref.watch(
      supplierOrderDetailsControllerProvider.select(
            (value) => value.order,
      ),
    );
    // print('order>>'+order!.id.toString());
    switch (state) {
      case DataState.loading:
        // return CircularProgressIndicator();
        return SupplierOrderDetailsContentWidget(
          order: SupplierOrder.fake(),
          isLoading: true,
        );

      case DataState.success:
        return SupplierOrderDetailsContentWidget(
          order: order,
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
}