import 'package:flutter/material.dart';
import 'dart:math'; // For generating random heights
import 'Widgets/GalleryItem.dart';  // Import the separated GalleryItem widget

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(0.0), // Set the height of the AppBar
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8, // Set the width of the AppBar
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // 2 columns
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: galleryItems.length,
              itemBuilder: (context, index) {
                // Generate random height for each item
                double randomHeight = Random().nextDouble() * (300 - 150) + 150;  // Random height between 150 and 300

                return GalleryItem(
                  imagePath: galleryItems[index]['imagePath']!,
                  title: galleryItems[index]['title']!,
                  height: randomHeight,  // Pass the random height to the GalleryItem
                );
              },
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                // Handle photo upload action
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
              foregroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

// Sample gallery items
List<Map<String, String>> galleryItems = [
  {
    'imagePath': 'assets/images/Home_Screen/banner image 1.png',
    'title': 'Hikkaduwa',
  },
  {
    'imagePath': 'assets/images/Home_Screen/banner image 2.png',
    'title': 'Pinnawala',
  },
  {
    'imagePath': 'assets/images/Home_Screen/banner image 2.png',
    'title': 'Ella',
  },
  {
    'imagePath': 'assets/images/Home_Screen/banner image 1.png',
    'title': 'Nuwara Eliya',
  },

  // Add more items as necessary
];