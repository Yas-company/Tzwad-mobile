enum OrderTypeEnum {
  all(''),
  pending('pending'),
  accepted('accepted'),
  rejected('rejected'),
  paid('paid'),
  shipped('shipped'),
  delivered('delivered'),
  cancelled('cancelled');

  final String value;

  const OrderTypeEnum(this.value);
}
