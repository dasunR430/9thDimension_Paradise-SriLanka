import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:paradise_sri_lanka/Common/Enums/password_textfield_enum.dart';
import 'package:paradise_sri_lanka/Controllers/Authentication/forgot_password_controller.dart';

import '../../Widgets/auth_form_field.dart';



class ResetPasswordForm extends StatelessWidget {
  final ForgotPasswordController controller = ForgotPasswordController.instance;
  ResetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //Email Field
          Obx(() => AuthFormField(
            textController: controller.passwordController,
            onChanged: controller.onPasswordChanged,
            focusedColor: controller.passwordFocusedColor.value,
            label: "Password",
            passwordEnum: controller.passwordVisible.value
                ? PasswordTextFieldEnum.visible
                : PasswordTextFieldEnum.invisible,
            visibilityIconPressed: controller.onPasswordVisiblePressed,
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => AuthFormField(
            textController: controller.confirmPasswordController,
            onChanged: controller.onConfirmPasswordChanged,
            focusedColor: controller.confirmPasswordFocusedColor.value,
            label: "Confirm Password",
            passwordEnum: controller.confirmPasswordVisible.value
                ? PasswordTextFieldEnum.visible
                : PasswordTextFieldEnum.invisible,
            visibilityIconPressed: () => controller.onPasswordVisiblePressed(isConfirmPassword: true),
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() => AuthFormField(
            textController: controller.otpController,
            onChanged: controller.onOTPChanged,
            focusedColor: controller.otpFocusedColor.value,
            label: "One Time Password (OTP)",
          ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 50,
          ),

          //Send Email Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.onResetPasswordPressed,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: const Text("Confirm Reset"),
            ),
          ),

        ],
      ),
    );
  }
}