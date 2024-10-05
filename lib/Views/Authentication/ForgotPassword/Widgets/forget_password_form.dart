import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:paradise_sri_lanka/Controllers/Authentication/forgot_password_controller.dart';

import '../../Widgets/auth_form_field.dart';



class ForgetPasswordForm extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());
  ForgetPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          //Email Field
          Obx(() => AuthFormField(
              textController: controller.emailController,
              onChanged: controller.onEmailChanged,
              focusedColor: controller.emailFocusedColor.value,
              label: "Email",
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          //Send Email Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.onSendEmailPressed,
              style: Theme.of(context).elevatedButtonTheme.style,
              child: const Text("Send Email"),
            ),
          ),

        ],
      ),
    );
  }
}