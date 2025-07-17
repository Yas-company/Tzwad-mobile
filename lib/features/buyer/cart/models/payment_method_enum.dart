enum PaymentMethodEnum {
  cashOnDelivery(1),
  tap(2);

  final int value;

  const PaymentMethodEnum(this.value);
  //
  // static PaymentMethod fromValue(int value) {
  //   return PaymentMethod.values.firstWhere(
  //     (method) => method.value == value,
  //     orElse: () => cashOnDelivery,
  //   );
  // }
}