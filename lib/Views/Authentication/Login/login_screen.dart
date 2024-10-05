import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Common/Enums/password_textfield_enum.dart';
import 'package:paradise_sri_lanka/Controllers/Authentication/login_screen_controller.dart';
import 'package:paradise_sri_lanka/Utils/constants/text_strings.dart';
import '../Widgets/auth_form_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            // Background Image
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/screenbackground.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Form Elements
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    ConstantTexts.loginTitle,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email Field
                  Obx(
                        () => AuthFormField(
                      textController: controller.emailController,
                      onChanged: controller.onEmailChanged,
                      focusedColor: controller.emailFocusedColor.value,
                      label: ConstantTexts.email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  Obx(
                        () => AuthFormField(
                      textController: controller.passwordController,
                      onChanged: controller.onPasswordChanged,
                      focusedColor: controller.passwordFocusedColor.value,
                      label: ConstantTexts.password,
                      passwordEnum: controller.passwordVisible.value
                          ? PasswordTextFieldEnum.visible
                          : PasswordTextFieldEnum.invisible,
                      visibilityIconPressed: controller.onPasswordVisiblePressed,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.onForgotPasswordPressed,
                      child: Text(ConstantTexts.forgetPassword, style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {

                      controller.signIn(
                        controller.emailController.text,
                        controller.passwordController.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(319, 54),
                    ),
                    child: const Text(ConstantTexts.signIn),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: controller.onDoNotHaveAccountPressed,
                      child: Text(ConstantTexts.doNotHaveAccount, style: Theme.of(context).textTheme.bodyMedium,),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
