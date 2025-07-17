import 'package:tzwad_mobile/core/network/failure.dart';
import 'package:tzwad_mobile/core/util/data_state.dart';
import 'package:tzwad_mobile/features/buyer/address/models/address_model.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/payment_method_enum.dart';
import 'package:tzwad_mobile/features/buyer/cart/models/shipping_method_enum.dart';

class CheckoutState {
  final DataState checkoutDataState;
  final DataState getAddressesDataState;
  final PaymentMethodEnum paymentMethod;
  final ShippingMethodEnum shippingMethod;
  final List<AddressModel> addresses;
  final AddressModel? selectAddress;
  final String? coupon;
  final Failure? failure;

  CheckoutState({
    this.checkoutDataState = DataState.initial,
    this.getAddressesDataState = DataState.initial,
    this.paymentMethod = PaymentMethodEnum.cashOnDelivery,
    this.shippingMethod = ShippingMethodEnum.pickUpSite,
    this.addresses = const [],
    this.selectAddress,
    this.coupon,
    this.failure,
  });

  CheckoutState copyWith({
    DataState? checkoutDataState,
    DataState? getAddressesDataState,
    PaymentMethodEnum? paymentMethod,
    ShippingMethodEnum? shippingMethod,
    List<AddressModel>? addresses,
    AddressModel? selectAddress,
    String? coupon,
    Failure? failure,
  }) {
    return CheckoutState(
      checkoutDataState: checkoutDataState ?? this.checkoutDataState,
      getAddressesDataState: getAddressesDataState ?? this.getAddressesDataState,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      addresses: addresses ?? this.addresses,
      selectAddress: selectAddress ?? this.selectAddress,
      coupon: coupon ?? this.coupon,
      failure: failure ?? this.failure,
    );
  }
}
