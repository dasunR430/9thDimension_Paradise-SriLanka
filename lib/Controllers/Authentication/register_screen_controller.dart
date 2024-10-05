import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:paradise_sri_lanka/Services/API/Exceptions/authentication_exception.dart';
import 'package:paradise_sri_lanka/Services/API/authenticate.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';
import 'package:paradise_sri_lanka/Utils/validators/validation.dart';
import 'package:paradise_sri_lanka/Views/Navigation/navigation_screen.dart';

class RegisterScreenController extends GetxController{
  var firstNameFocusedColor = Colors.red.obs,
      lastNameFocusedColor = Colors.red.obs,
      emailFocusedColor = Colors.red.obs,
      countryFocusedColor = Colors.red.obs,
      passwordFocusedColor = Colors.red.obs,
      confirmPasswordFocusedColor = Colors.red.obs;

  var passwordVisible = false.obs, confirmPasswordVisible = false.obs;
  RxString countryPickerValue = "".obs;

  final TextEditingController firstNameController = TextEditingController(),
                              lastNameController = TextEditingController(),
                              emailController = TextEditingController(),
                              countryPickerController = TextEditingController(),
                              passwordController = TextEditingController(),
                              confirmPasswordController = TextEditingController();


  void onCreateAccountPressed() async{

    if(_validate()){
        AuthUser authUser = AuthUser.forRegister(email: emailController.text, password: passwordController.text, firstName: firstNameController.text, lastName: lastNameController.text, countryId: countryPickerValue.value);
        try{
          await ParadiseAuthenticate.register(authUser);
        }
        catch(e){
          if(e is AuthenticationException){
            Get.snackbar("Error", e.message);
          }
          else{
            Get.snackbar("Error", "An error occurred. Please try again later");
          }
          return;
        }
        Get.off(()=>NavigationScreen());
    }
  }


  void onPasswordVisiblePressed({bool isConfirmPassword = false}) {
    if(isConfirmPassword){
      confirmPasswordVisible.value = !confirmPasswordVisible.value;
      return;
    }
    passwordVisible.value = !passwordVisible.value;
  }

  void onFirstNameChanged(String value) {
    bool valid = Validator.validateSingleName(value, "firstName") == null;
    if (!valid &&
        firstNameFocusedColor.value != Colors.red) {
      firstNameFocusedColor.value = Colors.red;
    }
    else if(valid){
      firstNameFocusedColor.value = Colors.green;
    }
  }

  void onLastNameChanged(String value) {
    bool valid = Validator.validateSingleName(value, "lastName") == null;
    if (!valid &&
        lastNameFocusedColor.value != Colors.red) {
      lastNameFocusedColor.value = Colors.red;
    }
    else if(valid){
      lastNameFocusedColor.value = Colors.green;
    }
  }

  void onEmailChanged(String value) {
    bool valid = Validator.validateEmail(value) == null;
    if (!valid &&
        emailFocusedColor.value != Colors.red) {
      emailFocusedColor.value = Colors.red;
    }
    else if(valid){
      emailFocusedColor.value = Colors.green;
    }
  }

  void onCountryChanged(String value) {
    String passportCode = HelperFunctions.isoToPassportCode(value);
    countryPickerValue.value = passportCode;
    print(passportCode);
    bool valid = countryPickerValue.value != "" && countryPickerValue.value != "Unknown" ;
    if (!valid &&
        countryFocusedColor.value != Colors.red) {
      countryFocusedColor.value = Colors.red;
    }
    else if(valid){
      countryFocusedColor.value = Colors.green;
    }
  }

  void onPasswordChanged(String value) {
    bool valid = Validator.validatePassword(value) == null;
    if (!valid &&
        passwordFocusedColor.value != Colors.red) {
      passwordFocusedColor.value = Colors.red;
    }
    else if(valid){
      passwordFocusedColor.value = Colors.green;
    }
  }

  void onConfirmPasswordChanged(String value) {
    bool valid = ! (value.isEmpty || value != passwordController.text);
    if (!valid &&
        confirmPasswordFocusedColor.value != Colors.red) {
      confirmPasswordFocusedColor.value = Colors.red;
    }
    else if(valid){
      confirmPasswordFocusedColor.value = Colors.green;
    }
  }

  bool _validate() {
    String? message = Validator.validateSingleName(
        firstNameController.text, "First name") ??
        Validator.validateSingleName(lastNameController.text, "Last name") ??
        Validator.validateEmail(emailController.text) ??
        Validator.validatePassword(passwordController.text);

    if(message == null && (countryPickerValue.value == "" || countryPickerValue.value == "Unknown")){
      message = "Please select your country";
    }

    if (confirmPasswordController.text.isEmpty ||
        confirmPasswordController.text != passwordController.text) {
      message = 'Passwords do not match';
    }

    if (message != null) {
      Get.snackbar('Error', message);
      return false;
    }
    return true;
  }
}