import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/order/models/supplier_order_details_response_model.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/controller/supplier_order_details_state.dart';
import 'package:tzwad_mobile/features/order/ui/order_supplier/provider/supplier_order_provider.dart';

class SupplierOrderDetailsController extends AutoDisposeNotifier<SupplierOrderDetailsState> {
  @override
  SupplierOrderDetailsState build() {
    state = _onInit();
    return state;
  }
  SupplierOrderDetailsState _onInit() => SupplierOrderDetailsState();

  void showSupplierOrder(int id) async {
    final repository = ref.read(supplierOrderRepositoryProvider);
    state = state.copyWith(
      getSupplierOrderDetailsDataState: DataState.loading,
    );
    final result = await repository.showSupplierOrder(id);
    result.fold(
          (l) => state = state.copyWith(
            getSupplierOrderDetailsDataState: DataState.failure,
        failure: l,
      ),
          (r) => state = state.copyWith(
            getSupplierOrderDetailsDataState: DataState.success,
        order: r?.order??SupplierOrder(),
      ),
    );
  }

}


