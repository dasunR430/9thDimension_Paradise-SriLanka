import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn(String email, String password) async {
    try {

    } catch (e) {

      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    }
  }
}
