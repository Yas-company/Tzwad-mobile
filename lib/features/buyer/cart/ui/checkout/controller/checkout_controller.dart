import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/address/models/address_model.dart';
import 'package:tzwad_mobile/features/buyer/address/providers/cart_repository_provider.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/payment_method_enum.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/shipping_method_enum.dart';
import 'package:tzwad_mobile/features/buyer/cart/providers/cart_repository_provider.dart';

import 'checkout_state.dart';

class CheckoutController extends AutoDisposeNotifier<CheckoutState> {
  @override
  CheckoutState build() {
    state = _onInit();
    getAddresses();
    return state;
  }

  CheckoutState _onInit() => CheckoutState();

  void getAddresses() async {
    final repository = ref.read(addressRepositoryProvider);
    state = state.copyWith(
      getAddressesDataState: DataState.loading,
    );
    final result = await repository.getAddresses();
    result.fold(
      (l) => state = state.copyWith(
        getAddressesDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        getAddressesDataState: DataState.success,
        addresses: r,
        selectAddress: r.firstWhere(
          (address) => address.isDefault == true,
        ),
      ),
    );
  }

  void changePaymentMethod(PaymentMethodEnum paymentMethod) {
    state = state.copyWith(
      paymentMethod: paymentMethod,
    );
  }

  void changeShippingMethod(ShippingMethodEnum shippingMethod) {
    state = state.copyWith(
      shippingMethod: shippingMethod,
    );
  }

  void changeAddress(AddressModel? address) {
    state = state.copyWith(
      selectAddress: address,
    );
  }

  void changeCoupon(String coupon) {
    state = state.copyWith(
      coupon: coupon,
    );
  }

  void checkout() async {
    final repository = ref.read(cartRepositoryProvider);
    state = state.copyWith(
      checkoutDataState: DataState.loading,
    );
    final result = await repository.checkout(
      addressId: state.selectAddress?.id,
      paymentMethod: state.paymentMethod,
      shippingMethod: state.shippingMethod,
    );
    result.fold(
      (l) => state = state.copyWith(
        checkoutDataState: DataState.failure,
        failure: l,
      ),
      (r) => state = state.copyWith(
        checkoutDataState: DataState.success,
      ),
    );
  }
}
