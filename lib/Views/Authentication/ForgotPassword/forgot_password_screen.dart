import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/spacing_styles.dart';
import 'package:paradise_sri_lanka/Utils/constants/image_strings.dart';
import 'package:paradise_sri_lanka/Utils/constants/text_strings.dart';
import 'package:paradise_sri_lanka/Utils/helpers/helper_functions.dart';

import 'Widgets/forget_password_form.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: SpacingStyles.withOutAppBarPadding,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image
                  Image.asset(
                    ConstantImages.forgotPasswordImage,
                    width: HelperFunctions.screenWidth() * 0.3,
                  ),
                  const SizedBox(height: 30),
                  // Title
                  Text(
                    ConstantTexts.forgetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10),
                  // Subtitle
                  Text(
                    ConstantTexts.forgetPasswordSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  // Form
                  ForgetPasswordForm(),
                  const SizedBox(height: 56),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
