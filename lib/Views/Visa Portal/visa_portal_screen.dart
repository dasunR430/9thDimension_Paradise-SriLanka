import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paradise_sri_lanka/Views/Visa%20Type%20Selection/visa_type_selection_screen.dart';

class VisaPortalScreen extends StatelessWidget {
  const VisaPortalScreen({super.key});

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
                  'Visa Portal',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue, // Matching text color
                  ),
                ),
                const SizedBox(height: 40), // Add spacing between title and image

                // Add the image
                Image.asset(
                  'assets/images/visaportal.png',
                  height: 300, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40), // Add spacing between image and buttons

                // Apply for Visa Button
                ElevatedButton(
                  onPressed: () {
                    Get.to(()=>VisaTypeSelection());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    fixedSize: const Size(319, 54), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Match border radius
                    ),
                  ),
                  child: const Text(
                    'Apply for Visa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Add spacing between buttons
                // Check status of your visa Button
                ElevatedButton(
                  onPressed: () {
                    // Add action for "Check status of your visa" button
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Button color
                    fixedSize: const Size(319, 54), // Button size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Match border radius
                    ),
                  ),
                  child: const Text(
                    'Check status of your visa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ],
      ),
    );
  }
}
