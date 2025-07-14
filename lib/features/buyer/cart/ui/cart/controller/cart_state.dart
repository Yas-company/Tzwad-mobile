import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/cart_info_model.dart';

class CartState {
  final DataState getCartInfoDataState;
  final CartInfoModel? cartInfo;
  final Failure? failure;

  CartState({
    this.getCartInfoDataState = DataState.initial,
    this.cartInfo,
    this.failure,
  });

  CartState copyWith({
    DataState? getCartInfoDataState,
    CartInfoModel? cartInfo,
    Failure? failure,
  }) {
    return CartState(
      getCartInfoDataState: getCartInfoDataState ?? this.getCartInfoDataState,
      cartInfo: cartInfo ?? this.cartInfo,
      failure: failure ?? this.failure,
    );
  }
}
