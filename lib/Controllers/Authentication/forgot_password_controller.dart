import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Services/API/Exceptions/authentication_exception.dart';
import 'package:paradise_sri_lanka/Services/API/authenticate.dart';
import 'package:paradise_sri_lanka/Utils/validators/validation.dart';
import 'package:paradise_sri_lanka/Views/Authentication/ForgotPassword/reset_password_screen.dart';
import 'package:paradise_sri_lanka/Views/Authentication/Login/login_screen.dart';

class ForgotPasswordController extends GetxController {

  static ForgotPasswordController instance = Get.find();

  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmPasswordController = TextEditingController(),
      otpController = TextEditingController();

  var emailFocusedColor = Colors.red.obs,
      passwordFocusedColor = Colors.red.obs,
      confirmPasswordFocusedColor = Colors.red.obs,
      otpFocusedColor = Colors.red.obs;

  var passwordVisible = false.obs, confirmPasswordVisible = false.obs;


  void onSendEmailPressed() async {
    if (_validateEmail()) {
      try{
        await ParadiseAuthenticate.sendPasswordResetEmail(emailController.text);
      }
      catch(e){
        if(e is AuthenticationException){
          Get.snackbar('Error!', e.message);
          return;
        }
        else{
          Get.snackbar('Error!', "An error occurred. Please try again later.");
          return;
        }
      }
      Get.to(() => const ResetPasswordScreen());
    }
  }

  void onResetPasswordPressed() async {
    if (_validateResetPassword()) {
      try{
        await ParadiseAuthenticate.resetPassword(emailController.text, passwordController.text, otpController.text);
      }
      catch(e){
        if(e is AuthenticationException){
          Get.snackbar('Error!', e.message);
          return;
        }
        else{
          Get.snackbar('Error!', "An error occurred. Please try again later.");
          return;
        }
      }
    }
    Get.delete<ForgotPasswordController>();
    Get.off(()=>LoginScreen());
  }

  void onPasswordVisiblePressed({bool isConfirmPassword = false}) {
    if(isConfirmPassword){
      confirmPasswordVisible.value = !confirmPasswordVisible.value;
      return;
    }
    passwordVisible.value = !passwordVisible.value;
  }

  void onEmailChanged(String value) {
    if (Validator.validateEmail(value) != null &&
        emailFocusedColor.value != Colors.red) {
      emailFocusedColor.value = Colors.red;
    } else if (Validator.validateEmail(value) == null) {
      emailFocusedColor.value = Colors.green;
    }
  }

  void onPasswordChanged(String value) {
    bool valid = Validator.validatePassword(value) == null;
    if (!valid && passwordFocusedColor.value != Colors.red) {
      passwordFocusedColor.value = Colors.red;
    } else if (valid) {
      passwordFocusedColor.value = Colors.green;
    }
  }

  void onConfirmPasswordChanged(String value) {
    bool valid = !(value.isEmpty || value != passwordController.text);
    if (!valid && confirmPasswordFocusedColor.value != Colors.red) {
      confirmPasswordFocusedColor.value = Colors.red;
    } else if (valid) {
      confirmPasswordFocusedColor.value = Colors.green;
    }
  }

  void onOTPChanged(String value) {
    bool valid = !(value.isEmpty || value.length != 6 || !value.isNumericOnly);
    if (!valid && otpFocusedColor.value != Colors.red) {
      otpFocusedColor.value = Colors.red;
    } else if (valid) {
      otpFocusedColor.value = Colors.green;
    }
  }


  bool _validateEmail() {
    String? message = Validator.validateEmail(emailController.text);
    if (message != null) {
      Get.snackbar('Error!', message);
      return false;
    }
    return true;
  }

  bool _validateResetPassword() {
    String? message = Validator.validatePassword(passwordController.text);
    if (message != null) {
      Get.snackbar('Error!', message);
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar('Error!', "Passwords do not match");
      return false;
    }
    if(otpController.text.isEmpty){
      Get.snackbar('Error!', "OTP is required");
      return false;
    }
    if(otpController.text.length != 6){
      Get.snackbar('Error!', "OTP must be 6 digits");
      return false;
    }
    if(!otpController.text.isNumericOnly){
      Get.snackbar('Error!', "Invalid OTP");
      return false;
    }
    return true;
  }
}
