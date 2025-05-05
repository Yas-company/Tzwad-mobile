extension ValidationExtension on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    return contains(RegExp(r'\d')) && contains(RegExp(r'[a-zA-Z]'));
  }

  bool isValidSehatechId() {
    return contains(RegExp(r'[0-9]'));
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
      final validatedPhoneNumber = this!.isNotEmpty && this!.length >= 11 && this != '0';
      return validatedPhoneNumber;
    }
  }
}
