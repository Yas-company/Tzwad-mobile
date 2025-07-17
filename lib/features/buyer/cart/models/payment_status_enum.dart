enum PaymentStatusEnum {
  pending(1), // pending
  paid(2), // paid
  failed(3); // failed

  final int value;

  const PaymentStatusEnum(this.value);
  //
  // static PaymentStatusEnum fromValue(int value) {
  //   return PaymentStatusEnum.values.firstWhere(
  //     (status) => status.value == value,
  //     orElse: () => PaymentStatusEnum.pending,
  //   );
  // }
}
