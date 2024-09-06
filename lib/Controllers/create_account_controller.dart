import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CreateAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Reactive variables to store form values
  var name = ''.obs;
  var email = ''.obs;
  var country = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  // Validators
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password.value) {
      return 'Passwords do not match';
    }
    return null;
  }

  void createAccount() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();

      try {
        // Perform account creation logic (e.g., API call)
        // For demonstration, we are just showing a success message
        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        // Show Snackbar on exception
        Get.snackbar(
          'Error',
          'Failed to create account: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}
