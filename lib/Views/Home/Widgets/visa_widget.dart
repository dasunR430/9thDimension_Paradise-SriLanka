import 'package:flutter/material.dart';

class VisaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Apply for Visa",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: const DecorationImage(
            image: AssetImage('assets/images/Home_Screen/Frame 427318700.png'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Online Visa Portal",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontWeight: FontWeight.bold,
                fontSize: 16.0,

              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "Apply for tourist visa easily with online visa portal",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 16.0),
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
                  child: Text("Apply for VISA"),
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