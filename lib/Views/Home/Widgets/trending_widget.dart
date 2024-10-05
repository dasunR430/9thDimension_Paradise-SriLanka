// lib/views/components/trending_widget.dart
import 'package:flutter/material.dart';

class TrendingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Trending now",
              style: TextStyle(fontFamily:'Inter', fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 210.0,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildTrendingItem(context, 'assets/images/Home_Screen/Frame 427318697.png'),
                _buildTrendingItem(context, 'assets/images/Home_Screen/Frame 427318698.png'),
                _buildTrendingItem(context, 'assets/images/Home_Screen/Frame 427318699.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(BuildContext context, String imagePath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          imagePath, // Replace with your image path
          width: 343.0,
          height: 207.0,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



