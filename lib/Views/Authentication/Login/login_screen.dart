import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  //final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          //Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/screenbackground.png'), // Use your image here
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
                    //loginController.onEmailChanged(value);
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
                    //loginController.onPasswordChanged(value);
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
                      // Handle forgot password
                    },
                    child: const Text('Forgot password?'),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    // Handle sign-in logic
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(319, 54), // Button size as per your request
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