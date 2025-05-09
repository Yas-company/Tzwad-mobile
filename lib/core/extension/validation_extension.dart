extension ValidationExtension on String {
  String get validatePhoneNumber {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The phone number cannot be empty';
    }
    if (!startsWith('05')) {
      return 'Phone number must start with "05"';
    }
    if (length < 10) {
      return 'Phone number must be exactly 10 digits';
    }
    if (!isValidSaudiPhone()) {
      return 'Invalid phone number';
    }
    return '';
  }

  String get validatePassword {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The password cannot be empty';
    }
    if (length < 8) {
      return 'The password must be at least 8 characters';
    }
    List<String> errors = [];

    if (!RegExp(r'[A-Z]').hasMatch(this)) {
      errors.add('an uppercase letter');
    }
    if (!RegExp(r'[a-z]').hasMatch(this)) {
      errors.add('a lowercase letter');
    }
    if (!RegExp(r'[0-9]').hasMatch(this)) {
      errors.add('a number');
    }
    if (!RegExp(r'[!@#\$&*~%^()\-_=+{};:,<.>]').hasMatch(this)) {
      errors.add('a special character');
    }

    if (errors.isNotEmpty) {
      return 'Password must contain ${errors.join(', ')}.';
    }
    return '';
  }

  String validateRePassword(String password) {
    if (this != password) {
      return 'Password does not match';
    }
    return '';
  }

  String get validateName {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The name cannot be empty';
    }
    return '';
  }

  String get validateAddress {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The address cannot be empty';
    }
    return '';
  }

  String get validateOtpCode {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The otp code cannot be empty';
    }
    if (length < 4) {
      return 'The otp code must be 4 digits';
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
