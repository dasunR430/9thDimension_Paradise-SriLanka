import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:paradise_sri_lanka/Common/Enums/password_textfield_enum.dart';
import 'package:paradise_sri_lanka/Controllers/Authentication/register_screen_controller.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

import '../Widgets/auth_form_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final RegisterScreenController controller =
      Get.put(RegisterScreenController());

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            //Background Image
            Positioned(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/screenbackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Column(
              children: [
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Add some padding to position it nicely
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context); // Handle back button action
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 25, // You can adjust the size if needed
                        color: isDark
                            ? Colors.white
                            : Colors.black, // Change color if needed
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
                // Form Elements
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Create an Account and \nUnlock Exclusive Experiences',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Obx(
                            () => AuthFormField(
                              textController: controller.firstNameController,
                              onChanged: controller.onFirstNameChanged,
                              focusedColor:
                                  controller.firstNameFocusedColor.value,
                              label: "First Name",
                            ),
                          ),
                          const SizedBox(height: 20),

                          Obx(
                            () => AuthFormField(
                              textController: controller.lastNameController,
                              onChanged: controller.onLastNameChanged,
                              focusedColor:
                                  controller.lastNameFocusedColor.value,
                              label: "Last Name",
                            ),
                          ),
                          const SizedBox(height: 20),

                          Obx(
                            () => AuthFormField(
                              textController: controller.emailController,
                              onChanged: controller.onEmailChanged,
                              focusedColor: controller.emailFocusedColor.value,
                              label: "Email",
                            ),
                          ),
                          const SizedBox(height: 20),
                          Obx(
                            () => AuthFormField(
                              textController: controller.countryPickerController,
                              onChanged: controller.onCountryChanged,
                              focusedColor: controller.countryFocusedColor.value,
                              label: "Select your country",
                              isCountryPicker: true,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Password Field
                          Obx(
                            () => AuthFormField(
                              textController: controller.passwordController,
                              onChanged: controller.onPasswordChanged,
                              focusedColor:
                                  controller.passwordFocusedColor.value,
                              label: "Password",
                              passwordEnum: controller.passwordVisible.value
                                  ? PasswordTextFieldEnum.visible
                                  : PasswordTextFieldEnum.invisible,
                              visibilityIconPressed:
                                  controller.onPasswordVisiblePressed,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Obx(
                            () => AuthFormField(
                              textController:
                                  controller.confirmPasswordController,
                              onChanged: controller.onConfirmPasswordChanged,
                              focusedColor:
                                  controller.confirmPasswordFocusedColor.value,
                              label: "Confirm Password",
                              passwordEnum:
                                  controller.confirmPasswordVisible.value
                                      ? PasswordTextFieldEnum.visible
                                      : PasswordTextFieldEnum.invisible,
                              visibilityIconPressed: () {
                                controller.onPasswordVisiblePressed(
                                    isConfirmPassword: true);
                              },
                            ),
                          ),

                          const SizedBox(height: 30),

                          ElevatedButton(
                            onPressed: controller.onCreateAccountPressed,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(
                                  319, 54), // Button size as per your request
                            ),
                            child: const Text('Create Account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
