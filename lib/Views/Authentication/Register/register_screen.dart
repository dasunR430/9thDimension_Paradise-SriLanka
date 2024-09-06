import 'package:flutter/material.dart';
import 'package:paradise_sri_lanka/Common/Widgets/custom_dropdown_field.dart';

class CreateAccountPage extends StatelessWidget {
  CreateAccountPage({super.key});

  final List<String> countries = [
    'United States',
    'Canada',
    'India',
    'Australia',
    'United Kingdom',
    // Add more countries as needed
  ];

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

          Column(
            children: [
              SizedBox(height: 30),

              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0), // Add some padding to position it nicely
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Handle back button action
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30, // You can adjust the size if needed
                      color: Colors.black, // Change color if needed
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Form Elements
          Padding(
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

                TextField(
                  onChanged: (value) {
                    //loginController.onEmailChanged(value);
                  },
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),

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

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select your country',
                    border: OutlineInputBorder(),
                  ),
                  items: countries.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    // Handle gender selection
                  },
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

                const SizedBox(height: 20),

                TextField(
                  onChanged: (value) {
                    //loginController.onPasswordChanged(value);
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 30),


                ElevatedButton(
                  onPressed: () {
                    // Handle sign-in logic
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(319, 54), // Button size as per your request
                  ),
                  child: const Text('Create Account'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}