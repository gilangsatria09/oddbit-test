extension StringFormValidators on String {
  String? validateEmptyUsername() {
    if (isEmpty) {
      return 'Username cannot be empty!';
    }
    return null;
  }

  String? validateEmptyPassword() {
    if (isEmpty) {
      return 'Password cannot be empty!';
    }
    return null;
  }

  String? validateFormatUsername() {
    if (isEmpty) {
      return validateEmptyUsername();
    } else if (length < 3) {
      return 'Username must be at least 3 characters!';
    } else if (length > 16) {
      return 'Username must be less than 16 characters!';
    }
    return null;
  }

  String? validateFormatPassword() {
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*]).{8,}$',
    );

    if (isEmpty) {
      return 'Password cannot be empty!';
    }
    if (!passwordRegex.hasMatch(this)) {
      return 'At least 8 characters, including lower & uppercase letters, numbers, and special characters (!@#\\\$%^&*)';
    }
    return null;
  }
}
