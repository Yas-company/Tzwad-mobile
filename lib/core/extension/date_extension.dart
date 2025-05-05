import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String getFormatDash() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String getFormatSlash() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension NonNullDateExtension on DateTime? {
  String getFormatDash() {
    if (this != null) {
      return DateFormat('yyyy-MM-dd').format(this!);
    }
    return '_';
  }

  String getFormatSlash() {
    if (this != null) {
      return DateFormat('dd/MM/yyyy').format(this!);
    }
    return '_';
  }
}
