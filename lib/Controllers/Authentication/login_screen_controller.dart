import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Services/API/Exceptions/authentication_exception.dart';
import 'package:paradise_sri_lanka/Services/API/authenticate.dart';
import 'package:paradise_sri_lanka/Utils/validators/validation.dart';
import 'package:paradise_sri_lanka/Views/Authentication/ForgotPassword/forgot_password_screen.dart';
import 'package:paradise_sri_lanka/Views/Authentication/Register/register_screen.dart';
import 'package:paradise_sri_lanka/Views/Navigation/navigation_screen.dart';


class LoginController extends GetxController {

  var passwordVisible = false.obs;

  var emailFocusedColor = Colors.red.obs,
      passwordFocusedColor = Colors.red.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn(String email, String password) async {
    // try{
    //   await ParadiseAuthenticate.logout();
    // }
    // catch(e){
    //   print(e);
    // }
    if(_validate()){
      try {
        await ParadiseAuthenticate.login(AuthUser.forLogin(email: email, password: password));
      } catch (e) {
        if(e is AuthenticationException){
          Get.snackbar("Error", e.message);
        }
        else{
          Get.snackbar("Error", "An error occurred. Please try again later");
        }
        return;
      }
      Get.off(()=>NavigationScreen());
      print((await ParadiseAuthenticate.currentUser)?.userId);
    }

  }

  void onDoNotHaveAccountPressed(){
    Get.to(()=>RegisterScreen());
  }

  void onForgotPasswordPressed(){
    Get.to(()=>const ForgotPasswordScreen());
  }

  void onPasswordVisiblePressed() {
    passwordVisible.value = !passwordVisible.value;
  }

  void onEmailChanged(String value){
    if(Validator.validateEmail(value) != null && emailFocusedColor.value != Colors.red){
      emailFocusedColor.value = Colors.red;
    }
    else if(Validator.validateEmail(value) == null){
      emailFocusedColor.value = Colors.green;
    }
  }

  void onPasswordChanged(String value){
    if(value.isEmpty){
      passwordFocusedColor.value = Colors.red;
    }
    else{
      passwordFocusedColor.value = Colors.green;
    }
  }

  bool _validate(){
    String? message = Validator.validateEmail(emailController.text);
    if(message != null){
      Get.snackbar('Error', message);
      return false;
    }
    if(passwordController.text.isEmpty){
      Get.snackbar('Error', 'Enter the password');
      return false;
    }
    return true;
  }
}
