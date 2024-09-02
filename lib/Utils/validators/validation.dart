class Validator {
  //validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    //RegEx for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  //validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    //check minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    //check uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    //check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    //check for special characters
    if (!value.contains(RegExp(r'[!@#$%&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  // Validate Sri Lankan Phone Number
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    // RegEx for Sri Lankan phone number validation
    final phoneRegExp = RegExp(r'^(?:0)?7\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid mobile phone number format.';
    }

    return null;
  }

  //Validate single name
  static String? validateSingleName(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    //RegEx for name validation
    final nameRegExp = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ'-]+$");

    if (!nameRegExp.hasMatch(value)) {
      return 'Invalid $fieldName.';
    }

    return null;
  }
}