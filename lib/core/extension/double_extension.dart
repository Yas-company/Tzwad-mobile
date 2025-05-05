import 'package:tzwad_mobile/core/util/constants.dart';

extension NonNullDouble on double? {
  double orZero() {
    if (this == null) {
      return Constants.zero.toDouble();
    } else {
      return this!;
    }
  }
}
