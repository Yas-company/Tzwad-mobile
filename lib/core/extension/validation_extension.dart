extension ValidationExtension on String {
  String? get validatePhoneNumber {
    // final context = AppContext.context;
    if (isEmpty) {
      return 'The phone number cannot be empty';
    }
    if (length < 11) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? get validatePassword {
    if (isEmpty) {
      return 'The password cannot be empty';
    }
    if (length < 6) {
      return 'The password must be at least 6 characters';
    }
    return null;
  }

  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    return contains(RegExp(r'\d')) && contains(RegExp(r'[a-zA-Z]'));
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
