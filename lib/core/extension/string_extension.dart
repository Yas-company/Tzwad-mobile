import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tzwad_mobile/core/util/constants.dart';

extension StringExtension on String {
  String createMask(int visibleLength) {
    if (isEmpty) return '';
    int maskLength = length - visibleLength;
    return substring(maskLength) + '*' * maskLength;
  }

  String getFormatNumber() {
    final numberFormatter = NumberFormat.decimalPattern('en_US');
    return numberFormatter.format(num.parse(this));
  }

  void log() {
    if (kDebugMode) {
      print(this);
    }
  }
}

extension NonNullStringExtension on String? {
  String orEmpty() {
    if (this == null) {
      return Constants.empty;
    } else {
      return this!;
    }
  }

  String getPlaceHolderImage() {
    if (this == null) return '';
    return this!.split(' ').map((e) => e[0]).join('').toUpperCase();
  }

  String getFormatDash() {
    if (this != null) {
      final date = DateTime.parse(this!);
      return DateFormat('yyyy-MM-dd').format(date);
    }
    return '_';
  }

  String getFormatSlash() {
    if (this != null) {
      final date = DateTime.parse(this!);
      return DateFormat('dd/MM/yyyy').format(date);
    }
    return '_';
  }
}
