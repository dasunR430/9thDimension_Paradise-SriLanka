import 'package:flutter/material.dart';

class PassesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.0), // Add some space (16.0 pixels)
          Text(
            "Apply for Visa",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                image: AssetImage('assets/images/Home_Screen/Frame 427318702.png'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.0),
                Text(
                  "Explore more with Sri Lanka's exclusive travel passes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 18.0),
                Row(
                  children: [
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // Handle visa application logic
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.blue, backgroundColor: Colors.white, // Text color of the button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0), // Rounded corners
                        ),
                      ),
                      child: Text("Get Passes"),
                    ),
                  ],
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}