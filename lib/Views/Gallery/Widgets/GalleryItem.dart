import 'package:flutter/material.dart';

class GalleryItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final double height;  // New height parameter

  const GalleryItem({
    required this.imagePath,
    required this.title,
    required this.height,
  });

  Widget build(BuildContext context) {
    return Container(
      height: height,  // Use the random height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,  // Ensures the image covers the entire container
        ),
      ),
      child: Stack(
        children: [
          // White shading at the top and bottom
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.1),  // Top shade
                    Colors.transparent,              // Middle transparent
                    Colors.white.withOpacity(0.4),  // Bottom shade
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Text positioned at the bottom of the image
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
