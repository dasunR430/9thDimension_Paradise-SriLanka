import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/login_screen_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                  'Sign in',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Email Field
                TextField(
                  onChanged: (value) {
                    loginController.emailController.text = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                // Password Field
                TextField(
                  onChanged: (value) {
                    loginController.passwordController.text = value;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      //TODO
                    },
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                    loginController.signIn(
                      loginController.emailController.text,
                      loginController.passwordController.text,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(319, 54),
                  ),
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Handle sign-up or redirection
                    },
                    child: const Text("Don't have an account?"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
