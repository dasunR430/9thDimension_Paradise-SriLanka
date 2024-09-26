import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorController extends GetxController {
  static ErrorController instance = Get.find();

  void showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void showErrorDialog() {
    String message = "Fill this page before moving to the next";
    Get.defaultDialog(
      title: "Error",
      middleText: message,
      backgroundColor: Colors.red,
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
