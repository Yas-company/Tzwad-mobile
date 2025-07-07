import 'package:tzwad_mobile/core/resource/language_manager.dart';
import 'package:tzwad_mobile/core/resource/string_manager.dart';
import 'package:tzwad_mobile/core/util/app_context.dart';

extension ValidationExtension on String {
  String get validatePhoneNumber {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strPhoneEmpty.tr(context);
    }
    if (!startsWith('05')) {
      return AppStrings.strPhoneInvalidStart.tr(context);
    }
    if (length < 10) {
      return AppStrings.strPhoneInvalidLength.tr(context);
    }
    if (!isValidSaudiPhone()) {
      return AppStrings.strPhoneInvalidFormat.tr(context);
    }
    return '';
  }

  String get validatePassword {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strPasswordEmpty.tr(context);
    }
    if (length < 8) {
      return AppStrings.strPasswordMinLength.tr(context);
    }
    List<String> errors = [];

    if (!RegExp(r'[A-Z]').hasMatch(this)) {
      errors.add(AppStrings.strUppercaseLetter.tr(context));
    }
    if (!RegExp(r'[a-z]').hasMatch(this)) {
      errors.add(AppStrings.strLowercaseLetter.tr(context));
    }
    if (!RegExp(r'[0-9]').hasMatch(this)) {
      errors.add(AppStrings.strNumber.tr(context));
    }
    if (!RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>]').hasMatch(this)) {
      errors.add(AppStrings.strSpecialCharacter.tr(context));
    }

    if (errors.isNotEmpty) {
      return '${AppStrings.strPasswordComplexity.tr(context)} ${errors.join(', ')}.';
    }
    return '';
  }

  String validateRePassword(String password) {
    final context = AppContext.context;
    if (this != password) {
      return AppStrings.strPasswordMismatch.tr(context);
    }
    return '';
  }

  String get validateBusinessName {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strBusinessNameEmpty.tr(context);
    }
    return '';
  }

  String get validateName {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strNameEmpty.tr(context);
    }
    return '';
  }

  String get validateAddress {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strAddressEmpty.tr(context);
    }
    return '';
  }


  String get validateRequiredField {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strFieldRequired.tr(context);
    }
    return '';
  }

  String get validateOtpCode {
    final context = AppContext.context;
    if (isEmpty) {
      return AppStrings.strOtpEmpty.tr(context);
    }
    if (length < 6) {
      return AppStrings.strOtpInvalidLength.tr(context);
    }
    return '';
  }

  bool isValidSaudiPhone() {
    final regex = RegExp(r'^05[0-9]{8}$');
    return regex.hasMatch(this);
  }

  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~%^()\-_=+{};:,<.>]).{8,}$');
    return contains(regex);
  }

  bool isValidIban() {
    return RegExp(r'^EG\d{27}$').hasMatch(this);
  }
}

extension ValidationExtension1 on String? {
  bool isValidPhoneNumber() {
    if (this == null) {
      return false;
    } else {
      final validatedPhoneNumber = this!.isNotEmpty && this!.length >= 11;
      return validatedPhoneNumber;
    }
  }
}
