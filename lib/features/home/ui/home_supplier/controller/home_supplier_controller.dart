import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'home_supplier_state.dart';

class HomeSupplierController extends AutoDisposeNotifier<HomeSupplierState> {
  @override
  HomeSupplierState build() {
    state = _onInit();
    return state;
  }

  HomeSupplierState _onInit() => HomeSupplierState();
}
