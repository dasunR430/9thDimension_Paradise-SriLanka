
import 'package:flutter/material.dart';

class ToolsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tools",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToolItem1(
                  context, "Go Back in time", "assets/images/Home_Screen/Go Back in Time.png", () {
                // Add your action for "Go Back in time" here
              }),
              _buildToolItem12(
                  context, "My memory video", "assets/images/Home_Screen/My memory Video.png", () {
                // Add your action for "My memory video" here
              }),
            ],
          ),
          const SizedBox(height: 0.5), // Space between the rows

          _buildToolItem2(context, "Collect your Souvenirs",
              "assets/images/Home_Screen/Collect your Soveniours.png", () {
                // Add your action for "Collect your Souvenirs" here
              }),
        ],
      ),
    );
  }

  Widget _buildToolItem1(BuildContext context, String title, String imagePath, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: AspectRatio(
          aspectRatio: 1.0, // Ensures the cards are square and of equal size
          child: GestureDetector(
            onTap: onPressed, // Executes the passed action
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    //color: Colors.black.withOpacity(0.3), // Optional overlay
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensures text visibility
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolItem12(BuildContext context, String title, String imagePath, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: AspectRatio(
          aspectRatio: 1.0, // Ensures the cards are square and of equal size
          child: GestureDetector(
            onTap: onPressed, // Executes the passed action
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    //color: Colors.black.withOpacity(0.3), // Optional overlay
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Ensures text visibility
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolItem2(BuildContext context, String title, String imagePath,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity, // Takes up the entire screen width
        height: 150.0, // Adjust the height as needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            //color: Colors.black.withOpacity(0.3), // Optional overlay
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Ensures text visibility
                ),
              ),
            ),
          ),
          //child: Center(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Text(
          //       title,
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white, // Ensures text visibility
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
